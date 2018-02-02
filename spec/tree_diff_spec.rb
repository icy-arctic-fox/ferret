RSpec.describe Ferret::TreeDiff do
  subject(:tree_diff) { build(:tree_diff) }

  describe '#files_added' do
    let(:files) { build_list(:source_file, 5) }
    subject(:tree_diff) { build(:tree_diff, files_added: files) }
    subject { tree_diff.files_added }

    it 'has the expected contents' do
      is_expected.to eq(files)
    end

    it 'is immutable' do
      expect { subject << build(:source_file) }.to raise_error(RuntimeError, /frozen/)
    end
  end

  describe '#files_removed' do
    let(:files) { build_list(:source_file, 5) }
    subject(:tree_diff) { build(:tree_diff, files_removed: files) }
    subject { tree_diff.files_removed }

    it 'has the expected contents' do
      is_expected.to eq(files)
    end

    it 'is immutable' do
      expect { subject << build(:source_file) }.to raise_error(RuntimeError, /frozen/)
    end
  end

  describe '#files_modified' do
    let(:files) { build_list(:source_file, 5) }
    subject(:tree_diff) { build(:tree_diff, files_modified: files) }
    subject { tree_diff.files_modified }

    it 'has the expected contents' do
      is_expected.to eq(files)
    end

    it 'is immutable' do
      expect { subject << build(:source_file) }.to raise_error(RuntimeError, /frozen/)
    end
  end

  it 'is frozen' do
    is_expected.to be_frozen
  end
end