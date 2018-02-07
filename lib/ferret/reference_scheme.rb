module Ferret
  # Defines how to find a type of reference.
  # @abstract Base class for all reference schemes.
  class ReferenceScheme
    # @!method find_all(text)
    #   Attempts to find any and all references in the given text.
    #   @param text [String] Text to search through.
    #   @return [Enumerable<Reference>] References found in the text.
    #   @abstract
    abstract :find_all
  end
end