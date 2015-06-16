module Reorderable
  extend ActiveSupport::Concern

  class_methods do
    def reorder! resource_ids, scope = {}
      resource_ids.each_with_index do |resource_id, index|
        where(scope).find(resource_id).update_attribute(:number, index + 1)
      end
    end
  end

end