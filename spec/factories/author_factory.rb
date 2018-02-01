FactoryBot.define do
  factory :author, class: Ferret::Author do
    name 'Test Author'
    initialize_with { new(name) }
  end
end