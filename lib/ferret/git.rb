module Ferret
  module Git
  end
end

if Gem.loaded_specs.has_key?('rugged')
  require_relative 'git/git_author'
  require_relative 'git/git_branch'
  require_relative 'git/git_commit'
  require_relative 'git/git_tag'
  require_relative 'git/git_vcs_driver'
  require_relative 'git/github_reference'
  require_relative 'git/github_repository'
end