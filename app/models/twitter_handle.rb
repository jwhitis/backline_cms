class TwitterHandle < ActiveRecord::Base
  validates_presence_of :handle

  def self.handles
    @handles ||= pluck(:handle)
  end

  def self.reload
    @handles = nil
  end

  def self.display_order
    order(:created_at)
  end

end
