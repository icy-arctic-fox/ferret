FactoryBot.define do
  factory :directory, class: Ferret::Directory do
    sequence(:full_path) { |n| File.join(parent_directory, "dir-#{n}") }
    contents { build_list(:file, 5, parent_directory: full_path) +
        build_list(:directory, subdirectory_count, subdirectory_count: 0, parent_directory: full_path) }
    transient do
      parent_directory '/'
      subdirectory_count 3
    end
    initialize_with { new(full_path, contents) }
  end

  factory :file, aliases: [:fto], class: Ferret::File do
    sequence(:full_path) { |n| File.join(parent_directory, "#{n}.txt") }
    hash { 'deadbeef' * 5 }
    transient do
      parent_directory '/'
    end
    initialize_with { new(full_path, hash) }
  end
end