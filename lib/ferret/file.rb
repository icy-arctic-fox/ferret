require_relative 'file_tree_object'

module Ferret
  # Information about a file.
  class File < FileTreeObject
    # SHA-1 hash (in hexadecimal) of the file contents.
    # @return [String]
    attr_reader :hash

    # Creates information about a file.
    # @param full_path [String] Full path to the file.
    # @param hash [String] SHA-1 hash (in hexadecimal) of the file contents.
    def initialize(full_path, hash)
      @hash = hash
      super(full_path)
    end

    def ==(other)
      super && other.hash == hash
    end
  end
end