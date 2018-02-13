module Ferret
  # Defines all operations that can be performed on a specific type of repository.
  # @abstract Base class that defines all operations that can be performed on a repository.
  class VcsDriver
    # @!method file_tree_at_revision(revision)
    #   Retrieves the file tree of a repository at a specified revision.
    #   @param revision [RevisionId] Revision to get the tree structure at.
    #   @return [FileTree]
    #   @abstract
    abstract :file_tree_at_revision

    # @!method file_contents_at_revision(revision, file)
    #   Retrieves the raw file contents of a file at a specified revision.
    #   This method can accept a block.
    #   When a block is provided, the stream will automatically be disposed when the block returns.
    #   If a block isn't provided, then an +IO+ instance will be returned that contains the same stream.
    #   @param revision [RevisionId] Revision to get the files contents at.
    #   @param file [File] File to retrieve the contents of.
    #   @return [IO] Stream of the file contents, if no block was provided.
    #   @return [void] Block was provided to the method.
    #   @yieldparam io [IO] Stream of the file contents.
    #   @abstract
    abstract :file_contents_at_revision

    # @!method commits_on_branch(branch)
    #   Retrieves a set of commits that have occurred on a branch.
    #   @param branch [Branch] Branch to inspect for commits.
    #   @return [Enumerable<Commit>]
    #   @abstract
    abstract :commits_on_branch

    # @!method stats_from_commit(commit)
    #   Retrieves statistical information for a commit.
    #   @param commit [Commit] Commit to collect statistics for.
    #   @return [CommitStats]
    #   @abstract
    abstract :stats_from_commit

    # @!method branches_in_repository(repository)
    #   Retrieves a list of all known branches in a repository.
    #   @param repository [Repository] Repository to inspect.
    #   @return [Enumerable<Branch>]
    #   @abstract
    abstract :branches_in_repository

    # @!method tags_in_repository(repository)
    #   Retrieves a list of all known tags in the repository.
    #   @param repository [Repository] Repository to inspect.
    #   @return [Enumerable<Tag>]
    #   @abstract
    abstract :tags_in_repository
  end
end