require_relative 'segment'

module Ferret
  module Reporting
    class CommitListSegment < Segment
      def initialize(title, slug, commits)
        @commits = commits
        super(title, slug)
      end

      def to_obj
        {
            count: @commits.count,
            commits: @commits.map(&:to_obj)
        }
      end
    end
  end
end