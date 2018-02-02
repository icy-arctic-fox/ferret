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

    # Creates commit statistics.
    # @param opts [Hash<Symbol => Integer>] Totals for the commit.
    #   Omitting any of the values will set it to zero.
    # @option opts [Integer] :lines_added Number of lines added.
    # @option opts [Integer] :lines_removed Number of lines removed.
    # @option opts [Integer] :files_added Number of new files.
    # @option opts [Integer] :files_removed Number of deleted files.
    # @option opts [Integer] :files_modified Number of files changed.
    def initialize(opts = {})
      @lines_added    = opts[:lines_added]    || 0
      @lines_removed  = opts[:lines_removed]  || 0
      @files_added    = opts[:files_added]    || 0
      @files_removed  = opts[:files_removed]  || 0
      @files_modified = opts[:files_modified] || 0
      freeze
    end
  end
end