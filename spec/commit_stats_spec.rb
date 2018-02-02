RSpec.describe Ferret::CommitStats do
  subject(:stats) { build(:commit_stats) }

  describe '#lines_added' do
    let(:count) { 5 }
    subject(:stats) { build(:commit_stats, lines_added: count) }
    subject { stats.lines_added }

    it 'is the expected value' do
      is_expected.to eq(count)
    end

    context 'when omitted' do
      let(:count) { nil }

      it 'is zero' do
        is_expected.to eq(0)
      end
    end
  end

  describe '#lines_removed' do
    let(:count) { 5 }
    subject(:stats) { build(:commit_stats, lines_removed: count) }
    subject { stats.lines_removed }

    it 'is the expected value' do
      is_expected.to eq(count)
    end

    context 'when omitted' do
      let(:count) { nil }

      it 'is zero' do
        is_expected.to eq(0)
      end
    end
  end

  describe '#files_added' do
    let(:count) { 5 }
    subject(:stats) { build(:commit_stats, files_added: count) }
    subject { stats.files_added }

    it 'is the expected value' do
      is_expected.to eq(count)
    end

    context 'when omitted' do
      let(:count) { nil }

      it 'is zero' do
        is_expected.to eq(0)
      end
    end
  end

  describe '#files_removed' do
    let(:count) { 5 }
    subject(:stats) { build(:commit_stats, files_removed: count) }
    subject { stats.files_removed }

    it 'is the expected value' do
      is_expected.to eq(count)
    end

    context 'when omitted' do
      let(:count) { nil }

      it 'is zero' do
        is_expected.to eq(0)
      end
    end
  end

  describe '#files_modified' do
    let(:count) { 5 }
    subject(:stats) { build(:commit_stats, files_modified: count) }
    subject { stats.files_modified }

    it 'is the expected value' do
      is_expected.to eq(count)
    end

    context 'when omitted' do
      let(:count) { nil }

      it 'is zero' do
        is_expected.to eq(0)
      end
    end
  end

  it 'is frozen' do
    is_expected.to be_frozen
  end
end