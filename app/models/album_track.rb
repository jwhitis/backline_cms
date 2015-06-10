class AlbumTrack < Track
  belongs_to :album, counter_cache: :tracks_count

  validates_presence_of :album_id

  before_validation :set_number

  def set_number
    self.number ||= album.tracks_count + 1
  end

end
