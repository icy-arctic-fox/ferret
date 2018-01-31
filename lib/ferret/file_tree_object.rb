module Ferret
  # Minimum attributes that an object in a file tree can have.
  # @abstract Base type for all objects that can exist in a file tree.
  class FileTreeObject
    # Full name of the object.
    # This includes the relative directory path from the top of the repository.
    # @return [String]
    attr_reader :full_name
  end
end