require 'diff-lcs'

module Ferret
  # Central point for generating diff analysis.
  class DiffGenerator
    # Creates a diff generator.
    # @param source_driver [VcsDriver] Driver used to get source objects.
    # @param destination_driver [VcsDriver] Driver used to get destination objects.
    #   If this is +nil+, then the source_driver will be used for both drivers.
    def initialize(source_driver, destination_driver = nil)
      @source_driver      = source_driver
      @destination_driver = destination_driver || source_driver
      freeze
    end

    # Computes the difference between two branches.
    # @param source_branch [Branch] Branch to compare against.
    # @param destination_branch [Branch] Branch to compare to.
    # @return [BranchDiff] Differences between the branches.
    def between_branches(source_branch, destination_branch)
      return @source_driver.commit_diff_between_branches(source_branch, destination_branch) if @source_driver == @destination_driver && @source_driver.respond_to?(:commit_diff_between_branches)
      source_commits      = @source_driver.commits_on_branch(source_branch)
      destination_commits = @destination_driver.commits_on_branch(destination_branch)
      unmerged_commits, commits_ahead = diff_instances(source_commits, destination_commits)
      unmerged_stats = unmerged_commits.map { |commit| @source_driver.stats_from_commit(commit) }
      ahead_stats    = commits_ahead.map    { |commit| @destination_driver.stats_from_commit(commit) }
      BranchDiff.new(source_branch, destination_branch,
                     unmerged: unmerged_commits, ahead: commits_ahead,
                     unmerged_stats: unmerged_stats, ahead_stats: ahead_stats
      )
    end

    # Computes the difference between two code trees.
    # @param source_tree [FileTree] Tree to compare against.
    # @param destination_tree [FileTree] Tree to compare to.
    # @return [TreeDiff] Differences between the trees.
    def between_trees(source_tree, destination_tree)
      raise NotImplementedError
    end

    # Computes the difference between two code files.
    # @param source_file [File] File to compare against.
    # @param destination_file [File] File to compare to.
    # @return [FileDiff] Differences between the files.
    def between_files(source_file, destination_file)
      raise NotImplementedError
    end

    # Computes the difference between two code directories.
    # @param source_directory [Directory] Directory to compare against.
    # @param destination_directory [Directory] Directory to compare to.
    # @return [DirectoryDiff] Differences between the directories.
    def between_directories(source_directory, destination_directory)
      raise NotImplementedError
    end

    private

    # Compares two sets of instances and returns the differences between them.
    # The instances must have hash equality methods - #hash and #eql?.
    # The returned differences will be sorted, so custom comparative methods may be useful.
    # @param left [Enumerable] First set of instances to diff.
    # @param right [Enumerable] Second set of instances to diff.
    # @return [Array<Enumerable>] Two sets, the first with items only in +left+,
    #   and the second with items only in +right+.
    def diff_instances(left, right)
      mash = Hash[left.map { |l| [l, 0x1] }]
      right.each { |r| mash[r] |= 0x2 }
      left_only  = mash.select { |_, v| v == 0x1 }.map { |l, _| l }
      right_only = mash.select { |_, v| v == 0x2 }.map { |r, _| r }
      return left_only.sort, right_only.sort
    end
  end
end