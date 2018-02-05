require_relative '../author'

module Ferret
  module Git
    # Additional information git provides about users.
    class GitAuthor < Author
      # Email address of the user.
      # @return [String]
      attr_reader :email

      # Creates a new author.
      # @param name [String] Display name of the user.
      # @param email [String] Email address of the user.
      def initialize(name, email)
        @email = email
        super(name)
      end

      def ==(other)
        super && other.respond_to?(:email) && other.email == email
      end
    end
  end
end