class AlbumTrack < ActiveRecord::Base
  belongs_to :album, counter_cache: :tracks_count

  validates_presence_of :title

  before_validation :set_number

  def set_number
    self.number ||= album.tracks_count + 1
  end

  def self.display_order
    order(:number)
  end

end
