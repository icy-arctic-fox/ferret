require_relative 'report_renderer'

module Ferret
  module Reporting
    # Transforms report information into a JSON object.
    class JsonReportRenderer < ReportRenderer
      def render
        obj = {
            title:   report.title,
            time:    report.time,
            summary: report.summary
        }
        report.segments.each do |segment|
          obj[segment.slug] = segment.to_obj
        end
        obj.to_json
      end
    end
  end
end