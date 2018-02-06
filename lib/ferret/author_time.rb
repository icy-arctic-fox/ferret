module Ferret
  # Information about a user and when they performed an operation in the repository.
  class AuthorTime
    include Comparable

    # Author that performed the action.
    # @return [Author]
    attr_reader :author

    # Date and time when the action was performed.
    # @return [Time]
    attr_reader :time

    # Creates a new author time.
    # @param author [Author] Author that performed the action.
    # @param time [Time] Date and time when the action was performed.
    def initialize(author, time)
      @author = author
      @time   = time
      freeze
    end

    def ==(other)
      other.author == author && other.time == time
    end

    def <=>(other)
      time <=> other.time
    end
  end
end