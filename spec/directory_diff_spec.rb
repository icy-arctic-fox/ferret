RSpec.describe Ferret::DirectoryDiff do
  subject(:directory_diff) { build(:directory_diff) }

  describe '#objects_added' do
    let(:objects) { build_list(:fto, 5) }
    subject(:directory_diff) { build(:directory_diff, objects_added: objects) }
    subject { directory_diff.objects_added }

    it 'has the expected contents' do
      is_expected.to eq(objects)
    end

    it 'is immutable' do
      expect { subject << build(:fto) }.to raise_error(RuntimeError, /frozen/)
    end
  end

  describe '#objects_removed' do
    let(:objects) { build_list(:fto, 5) }
    subject(:directory_diff) { build(:directory_diff, objects_removed: objects) }
    subject { directory_diff.objects_removed }

    it 'has the expected contents' do
      is_expected.to eq(objects)
    end

    it 'is immutable' do
      expect { subject << build(:fto) }.to raise_error(RuntimeError, /frozen/)
    end
  end

  describe '#objects_modified' do
    let(:objects) { build_list(:fto, 5) }
    subject(:directory_diff) { build(:directory_diff, objects_modified: objects) }
    subject { directory_diff.objects_modified }

    it 'has the expected contents' do
      is_expected.to eq(objects)
    end

    it 'is immutable' do
      expect { subject << build(:fto) }.to raise_error(RuntimeError, /frozen/)
    end
  end

  it 'is frozen' do
    is_expected.to be_frozen
  end
end