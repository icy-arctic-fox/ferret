require_relative 'file_tree_object'

module Ferret
  # Information about a source directory.
  class Directory < FileTreeObject
    # Files and sub-directories in the directory.
    # @return [Array<FileTreeObject>]
    attr_reader :contents
  end
end