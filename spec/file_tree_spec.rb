RSpec.describe Ferret::FileTree do
  subject(:file_tree) { build(:file_tree) }

  describe '#objects' do
    let(:objects) { build_list(:fto, 5) }
    subject(:file_tree) { build(:file_tree, objects: objects) }
    subject { file_tree.objects }

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