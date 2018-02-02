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

  factory :tree_diff, class: Ferret::TreeDiff do
    files_added { build_list(:source_file, files_added_count) }
    files_removed { build_list(:source_file, files_removed_count) }
    files_modified { build_list(:source_file, files_modified_count) }
    transient do
      files_added_count 2
      files_removed_count 1
      files_modified_count 3
    end
    initialize_with { new(files_added, files_removed, files_modified) }
  end
end