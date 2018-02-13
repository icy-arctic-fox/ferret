require_relative 'segment'

module Ferret
  module Reporting
    class CommitSegment < Segment
      def initialize(commit, references)
        @commit     = commit
        @references = references
        title = [commit.author.author.name, commit.revision.id].join(' ')
        super(title, commit.revision.id)
      end

      def to_obj
        obj = {
            author_name: @commit.author.author.name,
            time:        @commit.author.time,
            revision:    @commit.revision.id,
            message:     @commit.message,
            short:       @commit.short_message,
            references:  @references.map(&:to_obj),
            stats: {
                lines_added:    @commit.stats.lines_added,
                lines_removed:  @commit.stats.lines_removed,
                files_added:    @commit.stats.files_added,
                files_removed:  @commit.stats.files_removed,
                files_modified: @commit.stats.files_modified
            }
        }
        if has_committer?
          obj[:commit_time]    = @commit.committer.time
          obj[:committer_name] = @commit.committer.author.name
        end
        if @commit.respond_to?(:short_revision)
          obj[:short_revision] = @commit.short_revision
        end
        obj
      end

      private

      def has_committer?
        @commit.respond_to?(:committer) && @commit.committer != @commit.author
      end
    end
  end
end