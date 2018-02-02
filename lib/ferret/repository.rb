module Ferret
  # Information about a place that holds source code.
  # @abstract Implemented by a sub-class based on the repository type.
  class Repository
    # Location at which the repository contents can be retrieved.
    # @return [String]
    attr_reader :url
  end
end