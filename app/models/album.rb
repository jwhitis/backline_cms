class Album < ActiveRecord::Base
  mount_uploader :cover_art, ImageUploader

  has_many :tracks, class_name: "AlbumTrack", dependent: :destroy

  validates_presence_of :title, :release_date, :cover_art

  def self.display_order
    order(release_date: :desc)
  end

  def self.published
    where(published: true)
  end

end