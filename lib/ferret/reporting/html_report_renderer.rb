require 'haml'
require_relative 'report_renderer'

module Ferret
  module Reporting
    # Transforms report information into HTML pages.
    class HtmlReportRenderer < ReportRenderer
      def render
        engine = Haml::Engine.new(report_template)
        engine.render(Object.new, report: report, &method(:render_segment))
      end

      private

      def render_segment(segment)
        segment_engine = Haml::Engine.new(segment_template(segment))
        segment_engine.render(Object.new, report: report, segment: segment.to_obj, &method(:render_segment))
      end

      def assets_dir
        ::File.join(::File.dirname(__FILE__), '..', '..', '..', 'assets', 'html')
      end

      def report_template
        report_template_file = ::File.join(assets_dir, 'report.haml')
        ::File.read(report_template_file)
      end

      def segment_template(segment)
        snake_case_name = snake_case(segment.class.to_s)
        segment_template_fie = ::File.join(assets_dir, snake_case_name + '.haml')
        ::File.read(segment_template_fie)
      end

      def snake_case(string)
        name = string.split('::').last
        name.gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
        gsub(/([a-z\d])([A-Z])/, '\1_\2').
        tr('-', '_').downcase
      end
    end
  end
end