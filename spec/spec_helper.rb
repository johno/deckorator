$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'deckorator'

class FakeModel
  def name
    'Fred Flinstone'
  end
end

class FakeModelDecorator
  include Deckorator::Delegator

  attr_accessor :decorated_object

  def initialize(object)
    @decorated_object = object
  end

  def yelling_name
    "#{name.upcase}!!!"
  end
end

class FakeController
  include Deckorator

  def show
    @fake_model = FakeModel.new
    @fake_model = decorate(@fake_model)
  end
end
