module Ferret
  # Collects all known differences between two files.
  class FileDiff
    # New lines that were added to the file.
    # @return [Array<SourceLine>]
    attr_reader :lines_added

    # Old lines that were removed from the file.
    # @return [Array<SourceLine>]
    attr_reader :lines_removed

    # Creates a file diff.
    # @param lines_added [Enumerable<SourceLine>] Set of lines that were added to the file.
    # @param lines_removed [Enumerable<SourceLine>] Set of lines that were removed from the file.
    def initialize(lines_added = [], lines_removed = [])
      @lines_added   = lines_added.to_a.dup.freeze
      @lines_removed = lines_removed.to_a.dup.freeze
      freeze
    end
  end
end