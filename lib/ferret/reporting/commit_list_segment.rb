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

      def to_s
        "#{@commits.count} commits\n" +
          @commits.map(&:to_s).map { |str| "* #{str}" }.join("\n")
      end
    end
  end
end