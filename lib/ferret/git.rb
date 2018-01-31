module Ferret
  # Implementation details for git repositories.
  module Git
  end
end

# Git functionality relies on the Rugged gem.
# Make sure that is installed and enabled.
if Gem.loaded_specs.has_key?('rugged')
  require_relative 'git/git_author'
  require_relative 'git/git_branch'
  require_relative 'git/git_commit'
  require_relative 'git/git_tag'
  require_relative 'git/git_vcs_driver'
  require_relative 'git/github_reference'
  require_relative 'git/github_repository'
end