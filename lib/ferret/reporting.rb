module Ferret
  module Reporting
  end
end

require_relative 'reporting/branch_diff_report_generator'
require_relative 'reporting/contributor_report_generator'
require_relative 'reporting/file_diff_report_generator'
require_relative 'reporting/html_report_renderer'
require_relative 'reporting/json_report_renderer'
require_relative 'reporting/report'
require_relative 'reporting/report_generator'
require_relative 'reporting/report_renderer'
require_relative 'reporting/tree_diff_report_generator'
require_relative 'reporting/xml_report_renderer'