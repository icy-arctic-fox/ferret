require_relative '../repository'

module Ferret
  module Git
    # Implementation details of a git repository.
    class GitRepository < Repository
      # Information needed to access the repository.
      # @return [nil] No authentication needed.
      # @return [UserPasswordAuth] Username and password needed.
      # @return [SshKeyAuth] SSH key needed.
      attr_reader :auth

      # Creates a reference to a git repository.
      # @param url [String] Location of where the repository can be accessed.
      # @param auth [nil, UserPasswordAuth, SshKeyAuth] Authentication method.
      def initialize(url, auth)
        @auth = auth
        super(url)
      end
    end
  end
end