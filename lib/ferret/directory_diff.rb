module Ferret
  # Collects all known differences between two directories.
  class DirectoryDiff
    # Tree objects that exist in the destination directory, but not the source directory.
    # @return [Array<FileTreeObject>]
    attr_reader :added_objects

    # Tree objects that exist in the source directory, but not the destination directory.
    # @return [Array<FileTreeObject>]
    attr_reader :deleted_objects

    # Tree objects that exist in both directories, but have different contents.
    # @return [Array<FileTreeObject>]
    attr_reader :modified_objects
  end
end