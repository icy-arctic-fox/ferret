module Ferret
  # Collects all known differences between two branches.
  class BranchDiff
    # Branch used as the base.
    # @return [Branch]
    attr_reader :source_branch

    # Branch used as the target.
    # @return [Branch]
    attr_reader :destination_branch

    # Commits that exist on the source branch, but not the destination branch.
    # @return [Array<Commit>]
    attr_reader :unmerged_commits

    # Commits that exist on the destination branch, but not the source branch.
    # @return [Array<Commit>]
    attr_reader :commits_ahead

    # Statistics for commits that haven't been merged.
    # This array is parallel to +unmerged_commits+.
    # @return [Array<CommitStats>]
    attr_reader :unmerged_stats

    # Statistics for commits that only exist on the destination branch.
    # This array is parallel to +commits_ahead+.
    # @return [Array<CommitStats>]
    attr_reader :ahead_stats

    # Creates a branch difference.
    # @param source_branch [Branch] Branch used as the base.
    # @param destination_branch [Branch] Branch used as the target.
    # @param commits [Hash] Sets of commits.
    # @option commits [Enumerable<Commit>] :unmerged Commits that exist on +source_branch+,
    #   but not +destination_branch+.
    # @option commits [Enumerable<Commit>] :ahead Commits that exist on +destination_branch+,
    #   but not +source_branch+.
    # @option commits [Enumerable<CommitStats>] :unmerged_stats Statistics for commits that haven't been merged.
    # @option commits [Enumerable<CommitStats>] :ahead_stats Statistics for commits that only exist on the destination branch.
    def initialize(source_branch, destination_branch, commits = {
        unmerged: [], ahead: [], unmerged_stats: [], ahead_stats: []})
      @source_branch      = source_branch
      @destination_branch = destination_branch
      @unmerged_commits   = commits[:unmerged].to_a.dup.freeze
      @commits_ahead      = commits[:ahead].to_a.dup.freeze
      @unmerged_stats     = commits[:unmerged_stats].to_a.dup.freeze
      @ahead_stats        = commits[:ahead_stats].to_a.dup.freeze
      freeze
    end
  end
end