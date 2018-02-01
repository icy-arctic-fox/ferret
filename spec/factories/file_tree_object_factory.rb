FactoryBot.define do
  factory :directory, class: Ferret::Directory do
    full_path '/foo/bar'
    contents do
      arr  = build_list(:file, 5)
      arr += build_list(:directory, 5, build_subdirectories: false) unless build_subdirectories
      arr
    end
    transient do
      build_subdirectories true # Set to false to disable generating sub-directory objects.
    end
    initialize_with { new(full_path, contents) }
  end

  factory :file, aliases: [:fto], class: Ferret::File do
    full_path '/foo/bar/baz.txt'
    hash { 'deadbeef' * 5 }
    initialize_with { new(full_path, hash) }
  end
end