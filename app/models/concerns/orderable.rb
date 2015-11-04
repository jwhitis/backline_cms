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
      assign_positions!(resource_ids, scope)

      # Send any remaining resources to the bottom of the list
      remaining_ids = where(scope).pluck(:id) - resource_ids.map(&:to_i)
      assign_positions!(remaining_ids, scope, resource_ids.size)
    end

    def assign_positions! resource_ids, scope = {}, starting_position = 0
      resource_ids.each_with_index do |id, index|
        position = starting_position + index + 1
        where(scope).find(id).update_attribute(:position, position)
      end
    end
  end

end