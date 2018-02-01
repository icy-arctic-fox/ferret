module Ferret
  # Information about a line in a source code file.
  class SourceLine
    # Line number being referenced.
    # @return [Integer]
    attr_reader :number

    # Text on the line.
    # @return [String]
    attr_reader :content

    # Creates information about a line of source code.
    # @param number [Integer] Line number being referenced in a file.
    # @param content [String] Text on the line.
    def initialize(number, content)
      @number  = number
      @content = content
      freeze
    end
  end
end