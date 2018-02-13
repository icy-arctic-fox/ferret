require_relative 'report_renderer'

module Ferret
  module Reporting
    # Transforms report information into plain text document.
    class TextReportRenderer < ReportRenderer
      def render
        output = "#{report.title}\n#{'=' * report.title.length}\n\n#{report.summary}\nGenerated on #{report.time.strftime('%c')}.\n\n"
        rendered_segments = report.segments.map(&method(:render_segment))
        output + rendered_segments.join("\n\n")
      end

      private

      def render_segment(segment)
        "#{segment.title}\n#{'-' * segment.title.length}\n\n#{segment.to_s}"
      end
    end
  end
end