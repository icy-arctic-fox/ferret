module Ferret
  # Collects all known differences between two branches.
  class BranchDiff
    # Commits that exist on both branches.
    # @return [Array<Commit>]
    attr_reader :merged_commits

    # Commits that exist on the source branch, but not the destination branch.
    # @return [Array<Commit>]
    attr_reader :unmerged_commits

    # Commits that exist on the destination branch, but not the source branch.
    # @return [Array<Commit>]
    attr_reader :commits_ahead

    # Creates a branch difference.
    # @param merged_commits [Enumerable<Commit>] Commits that exist on both branches.
    # @param unmerged_commits [Enumerable<Commit>] Commits that exist on the source branch,
    #   but not the destination branch.
    # @param commits_ahead [Enumerable<Commit>] Commits that exist on the destination branch,
    #   but not the source branch.
    def initialize(merged_commits, unmerged_commits, commits_ahead)
      @merged_commits   = merged_commits.to_a.dup.freeze
      @unmerged_commits = unmerged_commits.to_a.dup.freeze
      @commits_ahead    = commits_ahead.to_a.dup.freeze
      freeze
    end
  end
end