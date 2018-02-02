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
      # @param committer [AuthorTime, nil] User and time the commit was made.
      #   Specify +nil+ to use the same value as +author+.
      def initialize(revision, message, author, committer = nil)
        @committer = committer || author
        super(revision, message, author)
      end
    end
  end
end