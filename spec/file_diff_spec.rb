RSpec.describe Ferret::FileDiff do
  subject(:file_diff) { build(:file_diff) }

  describe '#lines_added' do
    let(:lines_added) { build_list(:source_line, 5) }
    subject(:file_diff) { build(:file_diff, lines_added: lines_added) }
    subject { file_diff.lines_added }

    it 'is the expected value' do
      is_expected.to eq(lines_added)
    end

    it 'is immutable' do
      expect { subject << build(:source_line) }.to raise_error(RuntimeError, /frozen/)
    end
  end

  describe '#lines_removed' do
    let(:lines_removed) { build_list(:source_line, 5) }
    subject(:file_diff) { build(:file_diff, lines_removed: lines_removed) }
    subject { file_diff.lines_removed }

    it 'is the expected value' do
      is_expected.to eq(lines_removed)
    end

    it 'is immutable' do
      expect { subject << build(:source_line) }.to raise_error(RuntimeError, /frozen/)
    end
  end

  it 'is frozen' do
    is_expected.to be_frozen
  end
end