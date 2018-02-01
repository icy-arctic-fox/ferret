module Ferret
  # Your code goes here...
end

require_relative 'ferret/abstract'
require_relative 'ferret/author'
require_relative 'ferret/author_time'
require_relative 'ferret/branch'
require_relative 'ferret/branch_diff'
require_relative 'ferret/commit'
require_relative 'ferret/commit_stats'
require_relative 'ferret/diff_generator'
require_relative 'ferret/directory'
require_relative 'ferret/directory_diff'
require_relative 'ferret/file'
require_relative 'ferret/file_diff'
require_relative 'ferret/file_tree'
require_relative 'ferret/file_tree_object'
require_relative 'ferret/jira_reference'
require_relative 'ferret/reference'
require_relative 'ferret/reference_finder'
require_relative 'ferret/reporting'
require_relative 'ferret/repository'
require_relative 'ferret/revision_id'
require_relative 'ferret/revision_reference'
require_relative 'ferret/source_file'
require_relative 'ferret/source_line'
require_relative 'ferret/tag'
require_relative 'ferret/tree_diff'
require_relative 'ferret/vcs_driver'
require_relative 'ferret/version'


# Git functionality relies on the Rugged gem.
# Make sure that is installed and enabled.
require_relative 'ferret/git' if Gem.loaded_specs.has_key?('rugged')