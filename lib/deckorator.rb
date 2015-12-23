require 'deckorator/version'
require 'deckorator/delegator'
require 'deckorator/association'
require 'deckorator/deckorator_finder'

module Deckorator
  class << self
    def decorate(record)
      decorator = DeckoratorFinder.new(record).decorate
      decorator.new(record) if decorator
    end
  end
end
