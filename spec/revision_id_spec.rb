RSpec.describe Ferret::RevisionId do
  subject(:revision) { build(:revision) }

  describe '#id' do
    let(:id) { '01234567' * 5 }
    subject(:revision) { build(:revision, id: id) }
    subject { revision.id }

    it 'is the expected value' do
      is_expected.to eq(id)
    end
  end

  describe '#repository' do
    let(:repo) { build(:repo) }
    subject(:revision) { build(:revision, repository: repo) }
    subject { revision.repository }

    it 'is the expected value' do
      is_expected.to eq(repo)
    end
  end

  it 'is frozen' do
    is_expected.to be_frozen
  end
end