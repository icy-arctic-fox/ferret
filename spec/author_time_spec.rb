RSpec.describe Ferret::AuthorTime do
  subject(:a_t) { build(:author_time) }

  describe '#author' do
    let(:author) { build(:author) }
    subject(:a_t) { build(:author_time, author: author) }
    subject { a_t.author }

    it 'is the expected value' do
      is_expected.to eq(author)
    end
  end

  describe '#time' do
    let(:time) { 2.weeks.ago }
    subject(:a_t) { build(:author_time, time: time) }
    subject { a_t.time }

    it 'is the expected value' do
      is_expected.to eq(time)
    end
  end

  it 'is frozen' do
    is_expected.to be_frozen
  end
end