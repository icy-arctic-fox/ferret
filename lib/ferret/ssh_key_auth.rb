module Ferret
  # Authentication scheme based on SSH keys used to access a repository.
  class SshKeyAuth
    # Creates information about an SSH key-pair used for authentication.
    # @param private_key [String] Path to the private key file.
    # @param public_key [String, nil] Path to the public key file.
    #   Specify +nil+ to use the same path as +private_key+ but with '.pub' appended.
    def initialize(private_key, public_key = nil)
      @private_key = private_key
      @public_key  = public_key || private_key + '.pub'
      freeze
    end
  end
end