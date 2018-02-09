require 'thor'

module Ferret
  class CLI < Thor
    # Reporting sub-command for the command-line interface.
    class Report < Thor
      class_option :settings, type: :string, desc: 'Configuration settings file', required: true, banner: 'FILE', aliases: [:s]

      desc 'branchdiff <SRC_REPO> <SRC_BRANCH> <DEST_REPO> <DEST_BRANCH>', 'Generate a branch diff report'
      option :format, type: :string, desc: 'Output format', default: 'text', banner: 'FORMAT', aliases: [:f]
      option :workdir, type: :string, desc: 'Work directory', default: ENV['TEMP'], banner: 'DIRECTORY', aliases: [:w]
      option :title, type: :string, desc: 'Report title', default: 'Branch Diff', banner: 'TITLE', aliases: [:t]
      option :summary, title: :string, desc: 'Report summary', banner: 'TEXT', aliases: [:s]
      def branchdiff(source_repo, source_branch, destination_repo, destination_branch)
        settings   = Settings.load(options[:settings])
        src_repo   = settings.repositories[source_repo]
        dst_repo   = settings.repositories[destination_repo]
        factory    = VcsDriverFactory.new(RepositoryCache.new, options[:workdir])
        src_driver = factory.create(:git) # TODO: Grab type from src_repo.
        dst_driver = factory.create(:git) # TODO: Grab type from dst_repo.
        src_branch = src_driver.branches_in_repository(src_repo).find { |branch| branch.name == source_branch }
        dst_branch = dst_driver.branches_in_repository(dst_repo).find { |branch| branch.name == destination_branch }
        schemes    = settings.references_for_repository(src_repo) + settings.references_for_repository(dst_repo)
        finder     = ReferenceFinder.new(schemes)
        generator  = DiffGenerator.new(src_driver, dst_driver)
        diff       = generator.between_branches(src_branch, dst_branch)
        summary    = options[:summary] || "Commits different between #{src_branch.name} and #{dst_branch.name}"
        report_gen = Reporting::BranchDiffReportGenerator.new(options[:title], summary, finder, diff)
        report     = report_gen.generate
        renderer   = Reporting::ReportRendererFactory.new(report).create(options[:format].to_sym)
        puts renderer.render
      end
    end
  end
end