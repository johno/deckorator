require 'spec_helper'

describe Deckorator::Association do
  let(:obj) { FakeModelWithAssociation.new }
  let(:decorated_obj) { FakeModelWithAssociationDecorator.new(obj) }

  it 'decorates #fake with the FakeModelDecorator' do
    puts decorated_obj.inspect
    expect(decorated_obj.fake).to be_a(FakeModelDeckorator)
  end
end
