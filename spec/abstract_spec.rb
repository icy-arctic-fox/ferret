# Warning: Reflection ahead.
RSpec.describe 'Class#abstract' do
  let(:abstract_method_name) { :abstract_method }
  let(:klass) { Class.new }
  before(:each) do
    klass.send(:abstract, abstract_method_name)
  end

  it 'generates a method' do
    expect(klass.new).to respond_to(abstract_method_name)
  end

  it 'raises an exception when called' do
    expect { klass.new.send(abstract_method_name) }.to raise_error(NoMethodError)
  end

  it 'is private' do
    expect(Class.private_methods).to include(:abstract)
  end
end
