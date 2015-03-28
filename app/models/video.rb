class Video < ActiveRecord::Base
  validates_presence_of :title, :embed

  def self.display_order
    order(created_at: :desc)
  end

  def self.published
    where(published: true)
  end

end
