module Ferret
  # Implementation details for git repositories.
  module Git
  end
end

require_relative 'git/git_author'
require_relative 'git/git_branch'
require_relative 'git/git_commit'
require_relative 'git/git_repository'
require_relative 'git/git_tag'
require_relative 'git/git_vcs_driver'
require_relative 'git/github_reference'
require_relative 'git/github_repository'