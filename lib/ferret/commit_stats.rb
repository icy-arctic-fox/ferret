module Ferret
  # Statistical information about what changed between commits.
  class CommitStats
    # Number of lines added.
    # @return [Integer]
    attr_reader :lines_added

    # Number of lines removed.
    # @return [Integer]
    attr_reader :lines_removed

    # Number of new files.
    # @return [Integer]
    attr_reader :files_added

    # Number of deleted files.
    # @return [Integer]
    attr_reader :files_removed

    # Number of files changed.
    # @return [Integer]
    attr_reader :files_modified
  end
end