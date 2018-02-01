require_relative '../author'

module Ferret
  module Git
    # Additional information git provides about users.
    class GitAuthor < Author
      # Email address of the user.
      # @return [String]
      attr_reader :email

      # Creates a new author.
      # @param name Display name of the user.
      # @param email Email address of the user.
      def initialize(name, email)
        @email = email
        super(name)
      end
    end
  end
end