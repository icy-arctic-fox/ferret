require 'json'
require_relative 'report_renderer'

module Ferret
  module Reporting
    # Transforms report information into a JSON object.
    class JsonReportRenderer < ReportRenderer
      def initialize(report, pretty = false)
        @pretty = pretty
        super(report)
      end

      def render
        obj = {
            title:   report.title,
            time:    report.time,
            summary: report.summary
        }
        report.segments.each do |segment|
          obj[segment.slug] = segment.to_obj
        end
        if @pretty
          JSON.pretty_generate(obj)
        else
          JSON.generate(obj)
        end
      end
    end
  end
end