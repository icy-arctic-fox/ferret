RSpec.describe Ferret::File do
  subject(:file) { build(:file) }

  describe '#full_path' do
    let(:full_path) { '/tmp/fuzzy/ferret.txt' }
    subject(:file) { build(:file, full_path: full_path) }
    subject { file.full_path }

    it 'is the expected value' do
      is_expected.to eq(full_path)
    end
  end

  describe '#name' do
    let(:file_name) { 'ferret.txt' }
    let(:full_path) { File.join('/tmp', 'fuzzy', file_name) }
    subject(:file) { build(:file, full_path: full_path) }
    subject { file.name }

    it 'is the name part of the path' do
      is_expected.to eq(file_name)
    end
  end

  describe '#hash' do
    let(:hash) { 'abcdef01' * 5 }
    subject(:file) { build(:file, hash: hash) }
    subject { file.hash }

    it 'is the expected value' do
      is_expected.to eq(hash)
    end
  end

  it 'is frozen' do
    is_expected.to be_frozen
  end
end