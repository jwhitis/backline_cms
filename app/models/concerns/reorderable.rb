module Reorderable
  extend ActiveSupport::Concern

  class_methods do
    def reorder! resource_ids
      resource_ids.each_with_index do |resource_id, index|
        find(resource_id).update_attribute(:number, index + 1)
      end
    end
  end

end