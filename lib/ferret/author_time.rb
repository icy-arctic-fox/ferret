module Ferret
  # Information about a user and when they performed an operation in the repository.
  class AuthorTime
    # Author that performed the action.
    # @return [Author]
    attr_reader :author

    # Date and time when the action was performed.
    # @return [Time]
    attr_reader :time

    # Creates a new author time.
    # @param author Author that performed the action.
    # @param time Date and time when the action was performed.
    def initialize(author, time)
      @author = author
      @time   = time
      freeze
    end
  end
end