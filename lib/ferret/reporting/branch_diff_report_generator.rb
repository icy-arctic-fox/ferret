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
        references        = commit_references(@diff.unmerged_commits)
        branch_references = finder.search_branch(@diff.source_branch)
        references        = (branch_references + references).uniq
        [
            ReferenceListSegment.new('Important references', 'references', ref_segments(references)),
            CommitListSegment.new('Unmerged commits', 'unmerged_commits', commit_segments(@diff.unmerged_commits)),
            CommitListSegment.new('Missing commits', 'missing_commits', commit_segments(@diff.commits_ahead)),
            CommitListSegment.new('Merged commits', 'merged_commits', commit_segments(@diff.merged_commits))
        ]
      end

      private

      def commit_references(commits)
        reference_sets = commits.map do |commit|
          finder.search_commit(commit)
        end
        reference_sets.flatten.uniq
      end

      def ref_segments(references)
        references.map do |reference|
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