FactoryBot.define do
  factory :git_repository, aliases: [:repository, :repo], class: Ferret::Git::GitRepository do
    url 'git://localhost/foo.git'
    auth nil
    initialize_with { new(url, auth) }

    factory :github_repository, class: Ferret::Git::GitHubRepository do
      url 'https://github.com/icy-arctic-fox/ferret.git'
    end
  end

  factory :revision, class: Ferret::RevisionId do
    id { 'deadbeef' * 5 }
    repository { build(:repo) }
    initialize_with { new(id, repository) }
  end

  factory :git_branch, aliases: [:branch], class: Ferret::Git::GitBranch do
    name 'master'
    revision { build(:revision) }
    initialize_with { new(name, revision) }
  end

  factory :git_tag, aliases: [:tag], class: Ferret::Git::GitTag do
    name 'v1.0'
    revision { build(:revision) }
    initialize_with { new(name, revision) }
  end

  factory :git_commit, aliases: [:commit], class: Ferret::Git::GitCommit do
    revision { build(:revision) }
    message 'Just a test commit'
    author { build(:git_author) }
    committer { author }
    stats { build(:commit_stats) }
    initialize_with { new(revision, message, author, stats, committer) }
  end
end