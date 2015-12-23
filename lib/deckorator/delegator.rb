module Deckorator
  module Delegator
    def method_missing(method, *args, &block)
      decorated_object.respond_to?(method) ?
        decorated_object.send(method, *args, &block) :
        super
    end
  end
end
