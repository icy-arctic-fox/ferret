module Ferret
  # Minimum attributes that an object in a file tree can have.
  # @abstract Base type for all objects that can exist in a file tree.
  class FileTreeObject
    # Full path of the object.
    # This includes the relative directory path from the top of the repository.
    # @return [String]
    attr_reader :full_path

    # Creates a new file tree object
    # @param full_path [String] Full path of the object.
    def initialize(full_path)
      @full_path = full_path
      freeze
    end

    # Name of the object.
    # @return [String]
    def name
      ::File.basename(@full_path)
    end
  end
end