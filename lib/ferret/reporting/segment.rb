module Ferret
  module Reporting
    # Collection of information used in a report.
    # @abstract This is the base class for all report segment types.
    class Segment
      # Name of the segment.
      # @return [String]
      attr_reader :title

      # Machine-friendly name.
      # This should be snake_case.
      # @return [String]
      attr_reader :slug

      # @!method to_obj
      #   Generates an object (combination of hashes and arrays) that can be easily serialized.
      #   @return [Hash]
      #   @abstract
      abstract :to_obj

      # Creates a segment.
      # @param title [String] Name of the segment.
      # @param slug [String] Machine-friendly name.
      #   This should be snake_case.
      def initialize(title, slug)
        @title = title
        @slug  = slug
        freeze
      end
    end
  end
end