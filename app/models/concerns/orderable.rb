module Orderable
  extend ActiveSupport::Concern

  included do
    before_validation :set_position
    after_destroy :decrement_positions!

    def set_position
      self.position ||= self.class.where(order_scope).count + 1
    end

    def decrement_positions!
      resources = self.class.where(order_scope).where("position > ?", self.position)
      resources.update_all("position = position - 1")
    end

    def order_scope
      {} # Override this to scope the resources to be ordered.
    end
  end

  class_methods do
    def display_order
      order(:position)
    end

    def reorder! resource_ids, scope = {}
      resource_ids.each_with_index do |resource_id, index|
        where(scope).find(resource_id).update_attribute(:position, index + 1)
      end
    end
  end

end