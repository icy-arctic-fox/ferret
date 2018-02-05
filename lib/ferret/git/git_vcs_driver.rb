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
        raise NotImplementedError
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
        raise NotImplementedError
      end

      # Retrieves a set of commits that have occurred on a branch.
      # @param branch [Branch] Branch to inspect for commits.
      # @return [Enumerable<Commit>]
      def commits_on_branch(branch)
        raise NotImplementedError
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
          Branch.new(branch_name, revision)
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
                password: auth.instance_variable_get('@password'))
          when SshKeyAuth
            raise NotImplementedError # Rugged::Credentials::SshKey
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
          Rugged::Repository.clone_at(repo.url, path, credentials: cred)
        end
      end
    end
  end
end