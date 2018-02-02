FactoryBot.define do
  factory :git_repository, aliases: [:repository, :repo], class: Ferret::Git::GitRepository do
    url 'git://localhost/foo.git'
    auth nil
    initialize_with { new(url, auth) }

    factory :github_repository, class: Ferret::Git::GitHubRepository do
      url 'https://github.com/icy-arctic-fox/ferret.git'
    end
  end
end