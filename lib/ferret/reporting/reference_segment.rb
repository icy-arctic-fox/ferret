module Ferret
  module Reporting
    class ReferenceSegment < Segment
      def initialize(title, reference)
        @reference = reference
        super(title, reference.name)
      end

      def to_obj
        {
            _type: 'reference',
            name:  @reference.name,
            url:   @reference.url,
            type:  @reference.type
        }
      end

      def to_s
        @reference.name
      end
    end
  end
end