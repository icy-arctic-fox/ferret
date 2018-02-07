require_relative 'report_generator'

module Ferret
  module Reporting
    # Generates a report for the differences between two branches.
    class BranchDiffReportGenerator < ReportGenerator
      def initialize(title, summary, finder, diff)
        @diff = diff
        super(title, summary, finder)
      end

      protected

      def segments
        [
            ReferenceListSegment.new('Unmerged references', 'unmerged_refs', ref_segments(@diff.unmerged_commits)),
            CommitListSegment.new('Unmerged commits', 'unmerged_commits', commit_segments(@diff.unmerged_commits)),
            CommitListSegment.new('Missing commits', 'missing_commits', commit_segments(@diff.commits_ahead)),
            CommitListSegment.new('Merged commits', 'merged_commits', commit_segments(@diff.merged_commits))
        ]
      end

      private

      def ref_segments(commits)
        reference_sets = commits.map do |commit|
          finder.search_commit(commit).to_a
        end
        reference_sets.flatten.uniq.map do |reference|
          ReferenceSegment.new('References', reference)
        end
      end

      def commit_segments(commits)
        commits.reverse.map do |commit|
          references = finder.search_commit(commit).map do |reference|
            ReferenceSegment.new('References', reference)
          end
          CommitSegment.new(commit, references)
        end
      end
    end
  end
end