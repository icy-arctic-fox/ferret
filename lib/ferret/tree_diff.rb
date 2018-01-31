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
  end
end