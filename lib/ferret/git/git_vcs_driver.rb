require 'rugged'
require 'digest'
require_relative '../vcs_driver'

module Ferret
  module Git
    # Implementation details for operating on a git repository.
    class GitVcsDriver < VcsDriver
      # Creates a new driver for git repositories.
      # @param cache [RepositoryCache] Cache to track which repositories are actively being used.
      # @param work_dir [String] Path to the directory to use for temporary scratch work.
      #   Git repositories will be checked out to this location for processing.
      def initialize(cache, work_dir)
        @cache    = cache
        @work_dir = work_dir
        freeze
      end

      # Retrieves the file tree of a repository at a specified revision.
      # @param revision [RevisionId] Revision to get the tree structure at.
      # @return [FileTree]
      def file_tree_at_revision(revision)
        rugged        = rugged_repository(revision.repository)
        rugged_commit = rugged.lookup(revision.id)
        objects       = build_tree(rugged, rugged_commit.tree)
        FileTree.new(objects)
      end

      # Retrieves the raw file contents of a file at a specified revision.
      # This method can accept a block.
      # When a block is provided, the stream will automatically be disposed when the block returns.
      # If a block isn't provided, then an +IO+ instance will be returned that contains the same stream.
      # @param revision [RevisionId] Revision to get the files contents at.
      # @param file [File] File to retrieve the contents of.
      # @return [IO] Stream of the file contents, if no block was provided.
      # @return [void] Block was provided to the method.
      # @yieldparam io [IO] Stream of the file contents.
      def file_contents_at_revision(revision, file)
        blob = find_file(revision, file)
        io   = StringIO.new(blob.content)
        if block_given?
          begin
            yield io
          ensure
            io.close
          end
        else
          io
        end
      end

      # Retrieves a set of commits that have occurred on a branch.
      # @param branch [Branch] Branch to inspect for commits.
      # @return [Enumerable<Commit>]
      def commits_on_branch(branch)
        repository = branch.revision.repository
        walk_commits(branch.revision) do |rugged_commit|
          revision  = RevisionId.new(rugged_commit.oid, repository)
          author    = rugged_author_to_author_time(rugged_commit.author)
          committer = rugged_author_to_author_time(rugged_commit.committer)
          stats     = nil # TODO: Generate stats.
          GitCommit.new(revision, rugged_commit.message, author, stats, committer)
        end
      end

      # Retrieves a list of all known branches in a repository.
      # @param repository [Repository] Repository to inspect.
      # @return [Enumerable<Branch>]
      def branches_in_repository(repository)
        rugged_branches = rugged_repository(repository).branches
        rugged_branches.each_name(:remote).map do |remote_name|
          branch_name = remote_name.sub(/^origin\//, '') # Strip origin/ from beginning of string.
          target_id   = rugged_branches[remote_name].target_id
          revision    = RevisionId.new(target_id, repository)
          GitBranch.new(branch_name, revision)
        end
      end

      # Retrieves a list of all known tags in the repository.
      # @param repository [Repository] Repository to inspect.
      # @return [Enumerable<Tag>]
      def tags_in_repository(repository)
        rugged_tags = rugged_repository(repository).tags
        rugged_tags.map do |tag|
          revision = RevisionId.new(tag.target_id, repository)
          GitTag.new(tag.name, revision)
        end
      end

      private
      # Generates the path to the local copy of the repository.
      # @param repository [Repository] Repository to operate on.
      # @return [String] Path to where the repository (should) reside.
      def repository_path(repository)
        repo_dir = Digest::SHA2.hexdigest(repository.url)
        ::File.join(@work_dir, repo_dir)
      end

      # Generates the Rugged credentials equivalent for the given repository.
      # @param repository [Repository] Repository to retrieve credentials for.
      # @return [Object] One of Rugged's supported credential types.
      def rugged_credentials(repository)
        case (auth = repository.auth)
          when nil
            Rugged::Credentials::Default.new
          when UserPasswordAuth
            # Yeah, yeah, I know this is bad.
            Rugged::Credentials::UserPassword.new(
              username: auth.instance_variable_get('@username'),
              password: auth.instance_variable_get('@password')
            )
          when SshKeyAuth
            username = repository.url.split('@').first.split('://').last
            Rugged::Credentials::SshKey.new(
              username:   username,
              publickey:  auth.instance_variable_get('@public_key'),
              privatekey: auth.instance_variable_get('@private_key')
            )
          else
            raise "Unsupported authentication type for git - #{auth.class}"
        end
      end

      # Retrieves the +Rugged::Repository+ instance for a given repository.
      # @param repository [Repository] Repository to operate on.
      # @return [Rugged::Repository]
      def rugged_repository(repository)
        @cache.lookup(repository) do |repo|
          path = repository_path(repository)
          cred = rugged_credentials(repository)
          if Dir.exist?(path)
            update_repository(path, cred)
          else
            clone_repository(repo.url, path, cred)
          end
        end
      end

      # Performs an update on a local repository so that it is up-to-date with the remote.
      # @param path [String] Directory path to the local repository.
      # @param credentials [Object] Rugged credentials.
      # @return [Rugged::Repository] Updated repository instance.
      def update_repository(path, credentials)
        Rugged::Repository.init_at(path, credentials: credentials).tap do |rugged|
          rugged.fetch('origin', credentials: credentials)
        end
      end

      # Clones a remote repository.
      # @param url [String] URL of the remote repository.
      # @param path [String] Directory path to the local repository.
      # @param credentials [Object] Rugged credentials.
      # @return [Rugged::Repository] Cloned repository instance.
      def clone_repository(url, path, credentials)
        Rugged::Repository.clone_at(url, path, credentials: credentials)
      end

      # Iterates over commits reachable from a point on the DAG and maps them to a new value.
      # @param start [RevisionId] Reference to the revision to start at.
      # @yieldparam [Rugged::Commit] Commit information.
      # @yieldreturn [Object] Value to map the commit to.
      # @return [Enumerable] Collection of values returned from the yield block.
      def walk_commits(start, &block)
        repository = start.repository
        rugged     = rugged_repository(repository)
        walker     = Rugged::Walker.new(rugged)
        walker.push(start.id)
        walker.sorting(Rugged::SORT_TOPO | Rugged::SORT_DATE | Rugged::SORT_REVERSE)
        walker.map(&block)
      end

      # Converts author or committer information to an author instance used by this module.
      # @param rugged_author [Hash] Author information provided by Rugged.
      # @option rugged_author [String] :name Author's name.
      # @option rugged_author [String] :email Author's email address.
      # @option rugged_author [Time] :time Date and time information.
      # @return [AuthorTime] Constructed author information.
      def rugged_author_to_author_time(rugged_author)
        author = GitAuthor.new(rugged_author[:name], rugged_author[:email])
        AuthorTime.new(author, rugged_author[:time])
      end

      def build_tree(rugged, root, parent = '/')
        root.map do |entry|
          full_path = parent + entry[:name]
          case entry[:type]
            when :blob
              blob = rugged.lookup(entry[:oid])
              hash = FileHash.new(StringIO.new(blob.content)).hexdigest
              File.new(full_path, hash)
            when :tree
              subtree  = rugged.lookup(entry[:oid])
              contents = build_tree(rugged, subtree, full_path + '/')
              Directory.new(full_path, contents)
            else
              raise "Unknown tree entry type #{entry[:type]} - #{entry[:name]} [#{entry[:oid]}]"
          end
        end
      end

      def find_file(revision, file)
        rugged        = rugged_repository(revision.repository)
        rugged_commit = rugged.lookup(revision.id)
        find_file_in_tree(rugged, rugged_commit.tree, file)
      end

      def find_file_in_tree(rugged, tree, file)
        path = file.full_path[1..-1] # Strip off leading /
        while path.include?('/')
          parent, path = path.split('/', 2)
          tree = rugged.lookup(tree[parent][:oid])
        end
        rugged.lookup(tree[path][:oid])
      end
    end
  end
end