module Ferret
  # Information about changes made in a source file.
  class SourceFile
    # Reference to the file.
    # @return [File]
    attr_reader :file

    # Differences in the file.
    # @return [FileDiff]
    attr_reader :diff

    # Creates information about source file changes.
    # @param file [File] Reference to the file that changed.
    # @param diff [FileDiff] Differences in the file.
    def initialize(file, diff)
      @file = file
      @diff = diff
      freeze
    end
  end
end