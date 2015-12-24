require 'active_support/concern'
require 'deckorator/finder'

module Deckorator
  module Association
    extend ActiveSupport::Concern

    module ClassMethods
      attr_accessor :decorated_associations

      def decorate_association(*args)
        @decorated_associations = args
      end
    end

    def deckorator_define_association_methods
      return unless self.class.decorated_associations

      self.class.decorated_associations.each do |assoc|
        assoc_obj_or_objs = decorated_object.send(assoc)
        klass = Deckorator::Finder.find(assoc_obj_or_objs)
        instance_variable_set(
          "@_decorated_#{assoc}",
          klass.new(assoc_obj_or_objs)
        )

        self.class.send(:define_method, assoc) do
          instance_variable_get("@_decorated_#{assoc}")
        end
      end
    end
  end
end
