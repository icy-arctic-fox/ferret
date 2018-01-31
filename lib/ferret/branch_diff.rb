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
  end
end