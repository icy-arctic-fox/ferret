FactoryBot.define do
  factory :commit_stats, class: Ferret::CommitStats do
    lines_added 10
    lines_removed 7
    files_added 1
    files_removed 1
    files_modified 2
    initialize_with do
      new(lines_added:    lines_added,
          lines_removed:  lines_removed,
          files_added:    files_added,
          files_removed:  files_removed,
          files_modified: files_modified)
    end
  end
end