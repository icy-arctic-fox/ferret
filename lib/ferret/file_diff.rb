module Ferret
  # Collects all known differences between two files.
  class FileDiff
    # New lines that were added to the file.
    # @return [Array<SourceLine>]
    attr_reader :lines_added

    # Old lines that were removed from the file.
    # @return [Array<SourceLine>]
    attr_reader :lines_removed
  end
end