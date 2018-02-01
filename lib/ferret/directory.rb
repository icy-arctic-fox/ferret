require_relative 'file_tree_object'

module Ferret
  # Information about a source directory.
  class Directory < FileTreeObject
    # Files and sub-directories in the directory.
    # @return [Array<FileTreeObject>]
    attr_reader :contents

    # Creates information about a directory.
    # @param full_path [String] Full path to the directory.
    # @param contents [Enumerable<FileTreeObject>] Files and sub-directories.
    def initialize(full_path, contents = [])
      @contents = contents.to_a.dup.freeze
      super(full_path)
    end
  end
end