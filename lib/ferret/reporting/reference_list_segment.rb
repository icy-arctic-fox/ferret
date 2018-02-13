require_relative 'segment'

module Ferret
  module Reporting
    class ReferenceListSegment < Segment
      def initialize(title, slug, references)
        @references = references
        super(title, slug)
      end

      def to_obj
        {
            count:      @references.count,
            references: @references.map(&:to_obj)
        }
      end

      def to_s
        "#{@references.count} references\n" +
            @references.map(&:to_s).join(', ')
      end
    end
  end
end