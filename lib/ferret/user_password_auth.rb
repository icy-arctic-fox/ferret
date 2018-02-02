module Ferret
  # Authentication scheme for providing a username and password combination.
  class UserPasswordAuth
    # Creates the authentication scheme.
    # @param username [String] Name of the user to authenticate as.
    # @param password [String] Password associated with the user.
    def initialize(username, password)
      @username = username
      @password = password
      freeze
    end
  end
end