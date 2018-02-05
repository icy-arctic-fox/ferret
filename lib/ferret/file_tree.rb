module Ferret
  # Collection of files and directories that exist in the repository at a given point in time.
  class FileTree
    # Set of all objects in the file structure.
    # @return [Array<FileTreeObject>]
    attr_reader :objects

    # Creates a file tree.
    # @param objects [Enumerable<FileTreeObject>] Set of all objects in the file structure.
    def initialize(objects)
      @objects = objects.to_a.dup.freeze
      freeze
    end

    def ==(other)
      other.objects.sort == objects.sort
    end
  end
end