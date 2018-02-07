module Ferret
  module Reporting
    class ReferenceSegment < Segment
      def initialize(title, reference)
        @reference = reference
        super(title, reference.name)
      end

      def to_obj
        {
            name: @reference.name,
            url:  @reference.url,
            type: @reference.type
        }
      end
    end
  end
end