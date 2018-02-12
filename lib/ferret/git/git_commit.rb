require_relative '../commit'

module Ferret
  module Git
    # Additional information git provides in commits.
    class GitCommit < Commit
      # Information about the person that made the commit,
      # instead of who wrote the commit.
      # @return [AuthorTime]
      attr_reader :committer

      # Creates a reference to a commit.
      # @param revision [RevisionId] Unique identifier for this commit.
      # @param message [String] Message submitted with the commit.
      # @param author [AuthorTime] User and time the change was written.
      # @param stats [CommitStats] Statistical information about the commit.
      # @param committer [AuthorTime, nil] User and time the commit was made.
      #   Specify +nil+ to use the same value as +author+.
      def initialize(revision, message, author, stats, committer = nil)
        @committer = committer || author
        super(revision, message, author, stats)
      end

      def short_revision
        revision.id[0...7]
      end

      def ==(other)
        super && other.respond_to?(:committer) && other.committer == committer
      end
      alias eql? ==

      def hash
        super ^ committer.hash
      end

      def <=>(other)
        committer <=> other.committer
      end

      def to_s
        "#{short_revision} - #{author}: #{short_message}"
      end
    end
  end
end