require 'deckorator/version'
require 'deckorator/delegator'
require 'deckorator/finder'
require 'active_support/concern'

module Deckorator
  extend ActiveSupport::Concern

  class << self
    def decorate(record)
      if record.kind_of?(Array) || record.respond_to?(:all)
        decorator_array = []
        record.each do |r|
          decorator_array << decorate_object(r)
        end
        decorator_array
      else
        decorate_object(record)
      end
    end
  end

  included do
    helper_method :decorate if respond_to?(:helper_method)
    hide_action :decorate if respond_to?(:hide_action)
  end

  def decorate(record)
    Deckorator.decorate(record)
  end

  private

  def self.decorate_object(record)
    decorator = Deckorator::Finder.find(record)
    decorator.new(record) if decorator
  end
end
