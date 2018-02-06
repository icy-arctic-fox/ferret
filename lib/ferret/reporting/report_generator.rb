module Ferret
  module Reporting
    # Assembles information from various sources to create a report.
    # @abstract Base classes that all report generators use.
    class ReportGenerator
      # Creates a new report generator.
      # @param title [String] Name to give the generated report.
      # @param summary [String] Brief description of the report.
      def initialize(title, summary)
        @title   = title
        @summary = summary
        freeze
      end

      # Constructs the report.
      # @return [Report]
      def generate
        Report.new(@title, @summary, segments, Time.now)
      end

      protected

      # @!method segments
      #   Generates the segments to be used in the report.
      #   @return [Enumerable<Segment>]
      #   @abstract
      abstract :segments
    end
  end
end