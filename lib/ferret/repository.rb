module Ferret
  # Information about a place that holds source code.
  # @abstract Implemented by a sub-class based on the repository type.
  class Repository
    # Location at which the repository contents can be retrieved.
    # @return [String]
    attr_reader :url

    # Creates a reference to a source code repository.
    # @param url [String] Location at which the repository contents can be retrieved.
    def initialize(url)
      @url = url
      freeze
    end

    def ==(other)
      other.url == url
    end
    alias eql? ==

    def hash
      url.hash
    end

    def to_s
      url.to_s
    end
  end
end