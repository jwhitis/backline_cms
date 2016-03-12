class TwitterHandle < ActiveRecord::Base
  include SiteScope

  validates_presence_of :handle

  def self.display_order
    order(:created_at)
  end

end
