require 'deckorator/version'
require 'deckorator/delegator'
require 'deckorator/association'
require 'deckorator/deckorator_finder'

module Deckorator
  class << self
    def deckorate(record)
      if record.kind_of?(Array) || record.respond_to?(:all)
        decorator_array = []
        record.each do |r|
          decorator_array << deckorate_object(r)
        end
        decorator_array
      else
        deckorate_object(record)
      end
    end
  end

  private

  def self.deckorate_object(record)
    decorator = DeckoratorFinder.new(record).deckorate
    decorator.new(record) if decorator
  end
end
