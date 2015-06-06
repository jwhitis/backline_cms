class TwitterHandle < ActiveRecord::Base
  validates_presence_of :handle

  def self.display_order
    order(created_at: :desc)
  end

end
