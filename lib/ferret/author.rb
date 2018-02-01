module Ferret
  # Information about a person (or robot) that performed an operation in the repository.
  class Author
    # Display name of the user.
    # @return [String]
    attr_reader :name

    # Creates a new author.
    # @param name Display name of the user.
    def initialize(name)
      @name = name
      freeze
    end
  end
end