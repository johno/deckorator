class ApplicationDecorator
  include Deckorator::Delegator

  attr_accessor :decorated_object

  def initialize(object)
    @decorated_object = object
  end
end
