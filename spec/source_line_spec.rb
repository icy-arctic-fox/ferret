RSpec.describe Ferret::SourceLine do
  subject(:source_line) { build(:source_line) }

  describe '#number' do
    let(:number) { 5 }
    subject(:source_line) { build(:source_line, number: number) }
    subject { source_line.number }

    it 'is the expected value' do
      is_expected.to eq(number)
    end
  end

  describe '#content' do
    let(:content) { 'Fuzzy Ferret test data' }
    subject(:source_line) { build(:source_line, content: content) }
    subject { source_line.content }

    it 'is the expected value' do
      is_expected.to eq(content)
    end
  end

  it 'is frozen' do
    is_expected.to be_frozen
  end
end