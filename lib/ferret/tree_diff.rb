module Ferret
  # Collects all information between two trees.
  class TreeDiff
    # New files that have been added.
    # @return [Array<SourceFile>]
    attr_reader :files_added

    # Old files that have been removed.
    # @return [Array<SourceFile>]
    attr_reader :files_removed

    # Files that have had their contents changed.
    # @return [Array<SourceFile>]
    attr_reader :files_modified

    # Creates information about a diff between two trees.
    # @param files_added [Enumerable<SourceFile>] New files that have been added.
    # @param files_removed [Enumerable<SourceFile>] Old files that have been removed.
    # @param files_modified [Enumerable<SourceFile>] Files that have had their contents changed.
    def initialize(files_added, files_removed, files_modified)
      @files_added    = files_added.to_a.dup.freeze
      @files_removed  = files_removed.to_a.dup.freeze
      @files_modified = files_modified.to_a.dup.freeze
      freeze
    end
  end
end