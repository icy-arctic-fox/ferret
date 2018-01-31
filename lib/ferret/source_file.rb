module Ferret
  # Information about changes made in a source file.
  class SourceFile
    # Reference to the file.
    # @return [File]
    attr_reader :file

    # Differences in the file.
    # @return [FileDiff]
    attr_reader :diff
  end
end