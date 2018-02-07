require_relative '../reference'

module Ferret
  module Git
    # Reference to a GitHub pull request or issue.
    class GitHubReference < Reference
      def type
        :github
      end
    end
  end
end