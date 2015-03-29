class Photo < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  validates_presence_of :image

  def self.display_order
    order(created_at: :desc)
  end

  def self.published
    where(published: true)
  end

end
