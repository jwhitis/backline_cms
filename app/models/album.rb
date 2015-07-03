class Album < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  ARCHIVE_SIZE_LIMIT = 100.megabytes

  mount_uploader :cover_art, ImageUploader
  mount_uploader :archive, ArchiveUploader

  has_many :tracks, class_name: "AlbumTrack", dependent: :destroy

  validates_presence_of :title, :release_date, :cover_art
  validate :archive_size

  def archive_size
    if self.archive.file.size > ARCHIVE_SIZE_LIMIT
      errors.add(:archive, "can't be larger than #{number_to_human_size(ARCHIVE_SIZE_LIMIT)}")
    end
  end

  def downloadable?
    self.archive.present?
  end

  def self.display_order
    order(release_date: :desc)
  end

  def self.published
    where(published: true)
  end

end
