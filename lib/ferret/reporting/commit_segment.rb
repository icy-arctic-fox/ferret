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
            references:  @references.map(&:to_obj)
        }
        if has_committer?
          obj[:commit_time]    = @commit.committer.time
          obj[:committer_name] = @commit.committer.author.name
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