require 'haml'
require_relative 'report_renderer'

module Ferret
  module Reporting
    # Transforms report information into HTML pages.
    class HtmlReportRenderer < ReportRenderer
      def render
        engine = Haml::Engine.new(report_template)
        engine.render(Object.new, report: report)
      end

      private

      def assets_dir
        ::File.join(::File.dirname(__FILE__), '..', '..', '..', 'assets', 'html')
      end

      def report_template
        report_template_file = ::File.join(assets_dir, 'report.haml')
        ::File.read(report_template_file)
      end
    end
  end
end