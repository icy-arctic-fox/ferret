RSpec.describe Ferret::Directory do
  subject(:directory) { build(:directory) }

  describe '#full_path' do
    let(:full_path) { '/tmp/fuzzy' }
    subject(:directory) { build(:directory, full_path: full_path) }
    subject { directory.full_path }

    it 'is the expected value' do
      is_expected.to eq(full_path)
    end
  end

  describe '#name' do
    let(:dir_name) { 'ferret' }
    let(:full_path) { File.join('/tmp', 'fuzzy', dir_name) }
    subject(:directory) { build(:directory, full_path: full_path) }
    subject { directory.name }

    it 'is the name part of the path' do
      is_expected.to eq(dir_name)
    end
  end

  describe '#contents' do
    let(:contents) { build_list(:fto, 5) }
    subject(:directory) { build(:directory, contents: contents) }
    subject { directory.contents }

    it 'contains the expected values' do
      is_expected.to eq(contents)
    end

    it 'is immutable' do
      expect { subject << build(:fto) }.to raise_error(RuntimeError, /frozen/)
    end
  end

  it 'is frozen' do
    is_expected.to be_frozen
  end
end