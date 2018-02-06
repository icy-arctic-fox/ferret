module Ferret
  module Reporting
    # Creates a human (or machine) consumable output containing report information.
    # @abstract Base class that all report renderers use.
    class ReportRenderer
      def initialize(report)
        @report = report
        freeze
      end

      # @!method render
      #   Generates a string containing the serialized report information.
      #   @return [String] Serialized report information.
      #   @abstract
      abstract :render

      # @!method render_to_file(destination)
      #   Serializes the report information to a file.
      #   @param destination [String] Output file path.
      #   @return [void]
      #   @abstract
      abstract :render_to_file

      protected

      attr_reader :report
    end
  end
end