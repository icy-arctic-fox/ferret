RSpec.describe Ferret::Git::GitCommit do
  subject(:commit) { build(:git_commit) }

  describe '#revision' do
    let(:revision) { build(:revision) }
    subject(:commit) { build(:git_commit, revision: revision) }
    subject { commit.revision }

    it 'is the expected value' do
      is_expected.to eq(revision)
    end
  end

  describe '#message' do
    let(:message) { 'Fuzzy ferret' }
    subject(:commit) { build(:git_commit, message: message) }
    subject { commit.message }

    it 'is the expected value' do
      is_expected.to eq(message)
    end
  end

  describe '#author' do
    let(:author) { build(:git_author) }
    subject(:commit) { build(:git_commit, author: author) }
    subject { commit.author }

    it 'is the expected value' do
      is_expected.to eq(author)
    end
  end

  describe '#committer' do
    let(:committer) { build(:git_author) }
    subject(:commit) { build(:git_commit, committer: committer) }
    subject { commit.committer }

    it 'is the expected value' do
      is_expected.to eq(committer)
    end
  end

  describe '#stats' do
    let(:stats) { build(:commit_stats) }
    subject(:commit) { build(:git_commit, stats: stats) }
    subject { commit.stats }

    it 'is the expected value' do
      is_expected.to eq(stats)
    end
  end

  it 'is frozen' do
    is_expected.to be_frozen
  end
end