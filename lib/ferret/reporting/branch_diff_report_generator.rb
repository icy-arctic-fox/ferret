require_relative 'report_generator'

module Ferret
  module Reporting
    # Generates a report for the differences between two branches.
    class BranchDiffReportGenerator < ReportGenerator
      def initialize(diff)
        @diff = diff
        freeze
      end

      protected

      def segments
        [
            CommitListSegment.new('Unmerged commits', 'unmerged', commit_segments(@diff.unmerged_commits))
        ]
      end

      private

      def commit_segments(commits)
        commits.map do |commit|
          CommitSegment.new(commit)
        end
      end
    end
  end
end