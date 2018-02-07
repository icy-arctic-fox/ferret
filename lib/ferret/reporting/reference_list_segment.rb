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
    end
  end
end