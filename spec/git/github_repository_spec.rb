RSpec.describe Ferret::Git::GitHubRepository do
  subject(:github_repo) { build(:github_repository) }

  describe '#url' do
    let(:url) { 'https://github.com/git/git.git' }
    subject(:github_repo) { build(:github_repository, url: url) }
    subject { github_repo.url }

    it 'is the expected value' do
      is_expected.to eq(url)
    end
  end

  describe '#auth' do
    let(:auth) { build(:auth) }
    subject(:github_repo) { build(:github_repository, auth: auth) }
    subject { github_repo.auth }

    it 'is the expected value' do
      is_expected.to eq(auth)
    end
  end

  it 'is frozen' do
    is_expected.to be_frozen
  end
end