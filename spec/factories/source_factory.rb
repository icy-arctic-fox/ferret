FactoryBot.define do
  factory :source_line, class: Ferret::SourceLine do
    sequence(:number) { |n| n }
    content 'Test data'
    initialize_with { new(number, content) }
  end
end