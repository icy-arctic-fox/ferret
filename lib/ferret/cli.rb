require 'thor'
require 'ferret'
require_relative 'cli/report'

module Ferret
  # Command-line interface commands.
  class CLI < Thor
    desc 'remote <SUBCOMMAND> [ARGS]', 'Generate reports'
    subcommand 'report', Report
  end
end