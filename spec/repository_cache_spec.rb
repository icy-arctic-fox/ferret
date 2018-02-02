RSpec.describe Ferret::RepositoryCache do
  subject(:cache) { Ferret::RepositoryCache.new }
  let(:existing_repo) { double('repository') }
  let(:existing_value) { 'foobar' }
  before(:each) do
    cache.lookup(existing_repo) { |_| existing_value }
  end

  describe '#lookup' do
    it 'retrieves an existing repository' do
      expect(cache.lookup(existing_repo)).to eq(existing_value)
    end

    it 'yields for a non-existent repository' do
      new_repo = double('repository')
      expect { |b| cache.lookup(new_repo, &b) }.to yield_with_args(new_repo)
    end
  end

  describe '#clear' do
    it 'removes all entries' do
      cache.clear
      expect { |b| cache.lookup(existing_repo, &b) }.to yield_control
    end
  end
end