RSpec.describe Ferret::Git::GitTag do
  subject(:tag) { build(:git_tag) }

  describe '#name' do
    let(:name) { 'feature-tag' }
    subject(:tag) { build(:git_tag, name: name) }
    subject { tag.name }

    it 'is the expected value' do
      is_expected.to eq(name)
    end
  end

  describe '#revision' do
    let(:revision) { build(:revision) }
    subject(:tag) { build(:git_tag, revision: revision) }
    subject { tag.revision }

    it 'is the expected value' do
      is_expected.to eq(revision)
    end
  end

  it 'is frozen' do
    is_expected.to be_frozen
  end
end