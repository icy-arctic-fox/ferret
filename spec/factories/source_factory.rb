FactoryBot.define do
  factory :source_line, class: Ferret::SourceLine do
    sequence(:number) { |n| n }
    content 'Test data'
    initialize_with { new(number, content) }
  end

  factory :source_file, class: Ferret::SourceFile do
    file { build(:file) }
    file_diff { build(:file_diff) }
    initialize_with { new(file, file_diff) }
  end
end