RSpec.describe Ferret::Git::GitBranch do
  subject(:branch) { build(:git_branch) }

  describe '#name' do
    let(:name) { 'feature-branch' }
    subject(:branch) { build(:git_branch, name: name) }
    subject { branch.name }

    it 'is the expected value' do
      is_expected.to eq(name)
    end
  end

  describe '#revision' do
    let(:revision) { build(:revision) }
    subject(:branch) { build(:git_branch, revision: revision) }
    subject { branch.revision }

    it 'is the expected value' do
      is_expected.to eq(revision)
    end
  end

  it 'is frozen' do
    is_expected.to be_frozen
  end
end