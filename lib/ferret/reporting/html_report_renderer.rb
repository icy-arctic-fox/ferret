require 'haml'
require_relative 'report_renderer'

module Ferret
  module Reporting
    # Transforms report information into HTML pages.
    class HtmlReportRenderer < ReportRenderer
      def render
        vars   = {
            report:  report,
            css:     theme_text,
            js:      js_text,
            icon_js: icon_js_text
        }
        engine = Haml::Engine.new(report_template)
        engine.render(Object.new, vars, &method(:render_segment))
      end

      private

      def render_segment(segment)
        vars = {
            report:  report,
            segment: segment.to_obj
        }
        segment_engine = Haml::Engine.new(segment_template(segment))
        segment_engine.render(Object.new, vars, &method(:render_segment))
      end

      def assets_dir
        ::File.join(::File.dirname(__FILE__), '..', '..', '..', 'assets')
      end

      def theme_text
        css_theme_file = ::File.join(assets_dir, 'css', 'uikit.min.css')
        ::File.read(css_theme_file)
      end

      def js_text
        js_file = ::File.join(assets_dir, 'js', 'uikit.min.js')
        ::File.read(js_file)
      end

      def icon_js_text
        js_file = ::File.join(assets_dir, 'js', 'uikit-icons.min.js')
        ::File.read(js_file)
      end

      def report_template
        report_template_file = ::File.join(assets_dir, 'html', 'report.haml')
        ::File.read(report_template_file)
      end

      def segment_template(segment)
        snake_case_name = snake_case(segment.class.to_s)
        segment_template_fie = ::File.join(assets_dir, 'html', snake_case_name + '.haml')
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