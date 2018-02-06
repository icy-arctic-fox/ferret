module Ferret
  module Reporting
    # Assembled information to be rendered into a human (or machine) consumable format.
    class Report
      # Name of the report.
      # @return [String]
      attr_reader :title

      # Date and time the report was generated.
      # @return [Time]
      attr_reader :time

      # Brief description of the contents of the report.
      # @return [String]
      attr_reader :summary

      # Content sections in the report.
      # @return [Array<Segment>]
      attr_reader :segments

      # Creates a new report.
      # @param title [String] Name of the report.
      # @param summary [String] Brief description of the contents of the report.
      # @param segments [Enumerable<Segment>] Content sections in the report.
      # @param time [Time] Date and time the report was generated.
      def initialize(title, summary, segments, time = Time.now)
        @title    = title
        @summary  = summary
        @segments = segments.to_a.dup.freeze
        @time     = time
        freeze
      end
    end
  end
end