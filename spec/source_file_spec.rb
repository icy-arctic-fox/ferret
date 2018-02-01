RSpec.describe Ferret::SourceFile do
  subject(:source_file) { build(:source_file) }

  describe '#file' do
    let(:file) { build(:file) }
    subject(:source_file) { build(:source_file, file: file) }
    subject { source_file.file }

    it 'is the expected value' do
      is_expected.to eq(file)
    end
  end

  describe '#diff' do
    let(:diff) { build(:file_diff) }
    subject(:source_file) { build(:source_file, file_diff: diff) }
    subject { source_file.diff }

    it 'is the expected value' do
      is_expected.to eq(diff)
    end
  end

  it 'is frozen' do
    is_expected.to be_frozen
  end
end