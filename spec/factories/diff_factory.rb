FactoryBot.define do
  factory :file_diff, class: Ferret::FileDiff do
    lines_added { build_list(:source_line, lines_added_count) }
    lines_removed { build_list(:source_line, lines_removed_count) }
    transient do
      lines_added_count 5
      lines_removed_count 3
    end
    initialize_with { new(lines_added, lines_removed) }
  end
end