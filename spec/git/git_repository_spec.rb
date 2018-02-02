RSpec.describe Ferret::Git::GitRepository do
  subject(:git_repo) { build(:git_repository) }

  describe '#url' do
    let(:url) { 'git://foo.bar/baz.git' }
    subject(:git_repo) { build(:git_repository, url: url) }
    subject { git_repo.url }

    it 'is the expected value' do
      is_expected.to eq(url)
    end
  end

  describe '#auth' do
    let(:auth) { build(:auth) }
    subject(:git_repo) { build(:git_repository, auth: auth) }
    subject { git_repo.auth }

    it 'is the expected value' do
      is_expected.to eq(auth)
    end
  end

  it 'is frozen' do
    is_expected.to be_frozen
  end
end