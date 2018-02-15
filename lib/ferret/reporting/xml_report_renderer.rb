require 'nokogiri'
require_relative 'report_renderer'

module Ferret
  module Reporting
    # Transforms report information into XML document.
    class XmlReportRenderer < ReportRenderer
      def render
        builder = Nokogiri::XML::Builder.new do |xml|
          xml.report {
            xml.title report.title
            xml.time report.time
            xml.summary report.summary
            report.segments.each do |segment|
              build_segment_xml(xml, segment)
            end
          }
        end
        builder.to_xml
      end

      private
      def build_segment_xml(xml, segment)
        # This is dumb, either add a method to support this without reflection or update the docs if there is a method.
        xml.send(segment.slug.to_sym) {
          xml.title segment.title
          build_obj_xml(xml, segment.to_obj)
        }
      end

      def build_obj_xml(xml, obj)
        obj.each do |k, v|
          next if k.to_s.start_with?('_')
          case v
            when Hash
              xml.send(k) {
                build_obj_xml(xml, v)
              }
            when Array
              xml.send(k) {
                v.each do |i|
                  type = i[:_type] || :entry
                  xml.send(type) {
                    build_obj_xml(xml, i)
                  }
                end
              }
            else
              xml.send(k, v)
          end
        end
      end
    end
  end
end