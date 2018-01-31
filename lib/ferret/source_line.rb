module Ferret
  class SourceLine
    # Line number being referenced.
    # @return [Integer]
    attr_reader :number

    # Text on the line.
    # @return [String]
    attr_reader :content
  end
end