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
      source_commits      = @source_driver.commits_on_branch(source_branch)
      destination_commits = @destination_driver.commits_on_branch(destination_branch)
      sdiff = Diff::LCS.sdiff(source_commits, destination_commits)
      raise NotImplementedError
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
  end
end