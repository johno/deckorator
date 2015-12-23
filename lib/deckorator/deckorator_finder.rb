require 'active_support/core_ext/string/inflections'

module Deckorator
  class DeckoratorFinder
    attr_reader :object
    SUFFIX = 'Deckorator'

    def initialize(record)
      @object = record
    end

    def deckorate
      if object.nil?
        nil
      elsif object.class.respond_to?(:decorator_class)
        object.class.decorator_class
      elsif object.respond_to?(:decorator_class)
        object.decorator_class
      else
        klass = if object.class.respond_to?(:model_name)
          object.class.model_name
        elsif object.respond_to?(:model_name)
          object.model_name
        else
          object.class
        end
        "#{klass}#{SUFFIX}".constantize
      end
    end
  end
end
