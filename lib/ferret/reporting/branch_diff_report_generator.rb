require_relative 'report_generator'

module Ferret
  module Reporting
    # Generates a report for the differences between two branches.
    class BranchDiffReportGenerator < ReportGenerator
      def initialize(title, summary, diff)
        @diff = diff
        super(title, summary)
      end

      protected

      def segments
        [
            CommitListSegment.new('Unmerged commits', 'unmerged', commit_segments(@diff.unmerged_commits)),
            CommitListSegment.new('Missing commits', 'missing', commit_segments(@diff.commits_ahead)),
            CommitListSegment.new('Merged commits', 'merged', commit_segments(@diff.merged_commits))
        ]
      end

      private

      def commit_segments(commits)
        commits.reverse.map do |commit|
          CommitSegment.new(commit)
        end
      end
    end
  end
end