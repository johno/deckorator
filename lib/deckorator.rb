require 'deckorator/version'
require 'deckorator/delegator'
require 'deckorator/association'
require 'deckorator/finder'

module Deckorator
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

  private

  def self.decorate_object(record)
    decorator = Deckorator::Finder.find(record)
    decorator.new(record) if decorator
  end
end
