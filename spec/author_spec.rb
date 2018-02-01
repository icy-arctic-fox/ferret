RSpec.describe Ferret::Author do
  subject(:author) { build(:author) }

  describe '#name' do
    let(:name) { 'Fuzzy Ferret' }
    subject(:author) { build(:author, name: name) }
    subject { author.name }

    it 'is set to the expected value' do
      is_expected.to eq(name)
    end
  end

  it 'is frozen' do
    is_expected.to be_frozen
  end
end
