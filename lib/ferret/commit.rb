module Ferret
  # Snapshot of a point in time in the repository.
  # @abstract Implemented by a sub-class based on the repository type.
  class Commit
    include Comparable

    # Unique identifier for this commit.
    # @return [RevisionId]
    attr_reader :revision

    # Message submitted with the commit,
    # hopefully describing what changed since the previous commit.
    # @return [String]
    attr_reader :message

    # User that created the commit and time it was made.
    # @return [AuthorTime]
    attr_reader :author

    # Creates a reference to a commit.
    # @param revision [RevisionId] Unique identifier for this commit.
    # @param message [String] Message submitted with the commit.
    # @param author [AuthorTime] User and time the commit was created.
    def initialize(revision, message, author)
      @revision = revision
      @message  = message
      @author   = author
      freeze
    end

    def short_message
      first_line = message.split("\n", 2).first
      if first_line.length > 50
        first_line[0...50] + '...'
      else
        first_line
      end
    end

    def ==(other)
      other.revision == revision && other.message == message && other.author == author
    end
    alias eql? ==

    def hash
      revision.hash ^ message.hash ^ author.hash
    end

    def <=>(other)
      author <=> other.author
    end

    def to_s
      "#{revision} - #{author}: #{short_message}"
    end
  end
end