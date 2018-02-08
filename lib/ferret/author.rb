module Ferret
  # Information about a person (or robot) that performed an operation in the repository.
  class Author
    # Display name of the user.
    # @return [String]
    attr_reader :name

    # Creates a new author.
    # @param name [String] Display name of the user.
    def initialize(name)
      @name = name
      freeze
    end

    def ==(other)
      other.name == name
    end
    alias eql? ==

    def hash
      name.hash
    end

    def to_s
      name.to_s
    end
  end
end