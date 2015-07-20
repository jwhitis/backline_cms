module Reorderable
  extend ActiveSupport::Concern

  included do
    before_validation :set_number
    after_destroy :decrement_numbers!
  end

  def set_number
    self.number ||= self.class.where(order_scope).count + 1
  end

  def decrement_numbers!
    resources = self.class.where(order_scope).where("number > ?", self.number)
    resources.update_all("number = number - 1")
  end

  def order_scope
    {} # Override this to scope the resources to be ordered.
  end

  class_methods do
    def display_order
      order(:number)
    end

    def reorder! resource_ids, scope = {}
      resource_ids.each_with_index do |resource_id, index|
        where(scope).find(resource_id).update_attribute(:number, index + 1)
      end
    end
  end

end