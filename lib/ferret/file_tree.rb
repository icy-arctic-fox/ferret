module Ferret
  # Collection of files and directories that exist in the repository at a given point in time.
  class FileTree
    # Set of all objects in the file structure.
    # @return [Array<FileTreeObject>]
    attr_reader :objects
  end
end