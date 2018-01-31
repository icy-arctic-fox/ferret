module Ferret
  # Snapshot of a point in time in the repository.
  # @abstract Implemented by a sub-class based on the repository type.
  class Commit
    # Unique identifier for this commit.
    # @return [RevisionId]
    attr_reader :revision

    # Message submitted with the commit,
    # hopefully describing what changed since the previous commit.
    # @return [String]
    attr_reader :message

    # User that created the commit.
    # @return [AuthorTime]
    attr_reader :author
  end
end