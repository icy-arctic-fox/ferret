require_relative '../commit'

module Ferret
  module Git
    # Additional information git provides in commits.
    class GitCommit < Commit
      # Information about the person that made the commit,
      # instead of who wrote the commit.
      # @return [AuthorTime]
      attr_reader :committer
    end
  end
end