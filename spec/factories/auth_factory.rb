FactoryBot.define do
  factory :user_pass_auth, aliases: [:auth], class: Ferret::UserPasswordAuth do
    username 'ferret'
    password 'fuzzy'
    initialize_with { new(username, password) }
  end
end