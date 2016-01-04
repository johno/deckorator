require 'spec_helper'

describe Deckorator::Delegator do
  let(:obj) { FakeModel.new }
  let(:decorated_obj) { FakeModelDecorator.new(obj) }

  it 'delegates #name to FakeModel' do
    expect(decorated_obj.name).to eq('Fred Flinstone')
  end

  it 'raises an error when the method cannot be delegated' do
    expect {
      decorated_obj.trigger_method_missing
    }.to raise_error(NoMethodError)
  end

  it 'delegates class methods' do
    expect(decorated_obj.class.model_name).to eq('Fake')
  end
end
