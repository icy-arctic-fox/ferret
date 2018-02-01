FactoryBot.define do
  factory :author_time, class: Ferret::AuthorTime do
    author { build(:author) }
    time { 5.days.ago }
    initialize_with { new(author, time) }
  end
end