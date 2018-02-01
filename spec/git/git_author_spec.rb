RSpec.describe Ferret::Git::GitAuthor do
  subject(:author) { build(:git_author) }

  describe '#name' do
    let(:name) { 'Fuzzy Ferret' }
    subject(:author) { build(:git_author, name: name) }
    subject { author.name }

    it 'is the expected value' do
      is_expected.to eq(name)
    end
  end

  describe '#email' do
    let(:email) { 'fuzzy@ferret.com' }
    subject(:author) { build(:git_author, email: email) }
    subject { author.email }

    it 'is the expected value' do
      is_expected.to eq(email)
    end
  end

  it 'is frozen' do
    is_expected.to be_frozen
  end
end