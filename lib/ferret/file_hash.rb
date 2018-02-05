require 'digest'

module Ferret
  # Computes the hash of a file.
  # Each instance can only refer to one input stream.
  class FileHash
    # Creates a new file hashing instance.
    # @param io [IO] Input stream to hash the contents of.
    # @param digest [Digest] Digest algorithm to use.
    def initialize(io, digest = Digest::SHA2)
      @io     = io
      @digest = digest.new
      freeze
    end

    # Reads all contents from the input and produces a base-16 hash.
    # @return [String] Base-16 representation of the hashed contents.
    def hexdigest
      # Read bytes in chunks of the optimal digest size.
      while (chunk = @io.read(@digest.block_length))
        @digest.update(chunk)
      end
      @digest.hexdigest
    end

    # Utility method for quickly hashing a file.
    # @param path [String] Path to the file to hash the contents of.
    # @param digest [Digest] Digest algorithm to use.
    # @return [String] Base-16 representation of the hashed file contents.
    def self.of(path, digest = Digest::SHA2)
      ::File.open(path, 'rb') do |io|
        return new(io, digest).hexdigest
      end
    end
  end
end