module Ferret
  module Reporting
    # Creates the correct report renderer based on type.
    class ReportRendererFactory
      # Creates a new factory.
      # @param report [Report] Report to give to the renderer.
      def initialize(report)
        @report = report
        freeze
      end

      # Creates a report renderer based on type.
      # @param type [Symbol] Type of renderer to create.
      # @return [ReportRenderer]
      def create(type)
        case type
          when :json
            JsonReportRenderer.new(@report, true)
          when :text
            HtmlReportRenderer.new(@report)
          when :xml
            XmlReportRenderer.new(@report)
          else
            raise "Unknown report renderer type #{type}"
        end
      end
    end
  end
end