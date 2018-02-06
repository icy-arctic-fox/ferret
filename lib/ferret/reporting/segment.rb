module Ferret
  module Reporting
    # Collection of information used in a report.
    # @abstract This is the base class for all report segment types.
    class Segment
      # Name of the segment.
      # @return [String]
      attr_reader :title

      # @!method to_json
      #   Generates the JSON representation of the segment.
      #   @return [String]
      abstract :to_json

      # @!method to_xml
      #   Generates the XML representation of the segment.
      #   @return [String]
      abstract :to_xml

      # @!method to_html
      #   Generates the HTML representation of the segment.
      #   @return [String]
      abstract :to_html

      # Creates a segment.
      # @param title [String] Name of the segment.
      def initialize(title)
        @title = title
        freeze
      end
    end
  end
end