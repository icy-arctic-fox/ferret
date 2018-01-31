module Ferret
  # Information about a user and when they performed an operation in the repository.
  class AuthorTime
    # Author that performed the action.
    # @return [Author]
    attr_reader :author

    # Date and time when the action was performed.
    # @return [Time]
    attr_reader :time
  end
end