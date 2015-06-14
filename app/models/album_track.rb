class AlbumTrack < Track
  belongs_to :album, counter_cache: :tracks_count

  validates_presence_of :album_id

  before_validation :set_number
  after_destroy :decrement_track_numbers!

  def set_number
    self.number ||= album.tracks_count + 1
  end

  def decrement_track_numbers!
    tracks = album.tracks.where("number > ?", self.number)
    tracks.update_all("number = number - 1")
  end

end
