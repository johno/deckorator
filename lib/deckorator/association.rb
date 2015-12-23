require 'active_support/concern'

module Deckorator
  module Association
    extend ActiveSupport::Concern

    module ClassMethods
      def decorate_association(*args)
        puts args.inspect
      end
    end
  end
end
