FactoryBot.define do
  factory :author, class: Ferret::Author do
    name 'Test Author'
    initialize_with { new(name) }

    factory :git_author, class: Ferret::Git::GitAuthor do
      email 'test@example.com'
      initialize_with { new(name, email) }
    end
  end
end