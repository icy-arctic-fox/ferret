module Ferret
  # Collects all known differences between two directories.
  class DirectoryDiff
    # Tree objects that exist in the destination directory, but not the source directory.
    # @return [Array<FileTreeObject>]
    attr_reader :objects_added

    # Tree objects that exist in the source directory, but not the destination directory.
    # @return [Array<FileTreeObject>]
    attr_reader :objects_removed

    # Tree objects that exist in both directories, but have different contents.
    # @return [Array<FileTreeObject>]
    attr_reader :objects_modified

    # Creates information about differences between two directories.
    # @param objects_added [Enumerable<FileTreeObject>] Tree objects that exist in the destination directory,
    #   but not the source directory.
    # @param objects_removed [Enumerable<FileTreeObject>] Tree objects that exist in the source directory,
    #   but not the destination directory.
    # @param objects_modified [Enumerable<FileTreeObject>] Tree objects that exist in both directories,
    #   but have different contents.
    def initialize(objects_added, objects_removed, objects_modified)
      @objects_added    = objects_added.to_a.dup.freeze
      @objects_removed  = objects_removed.to_a.dup.freeze
      @objects_modified = objects_modified.to_a.dup.freeze
      freeze
    end
  end
end