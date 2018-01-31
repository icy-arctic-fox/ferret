require_relative '../author'

module Ferret
  module Git
    # Additional information git provides about users.
    class GitAuthor < Author
      # Email address of the user.
      # @return [String]
      attr_reader :email
    end
  end
end