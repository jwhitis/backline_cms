class AlbumTrack < Track
  belongs_to :album, counter_cache: :tracks_count

  validates_presence_of :album_id

  before_validation :set_number
  before_validation :set_downloadable
  after_destroy :decrement_track_numbers!

  def set_number
    self.number ||= album.tracks_count + 1
  end

  def set_downloadable
    self.downloadable = false if self.remove_audio?
    true # Object becomes invalid if a callback returns false
  end

  def decrement_track_numbers!
    tracks = album.tracks.where("number > ?", self.number)
    tracks.update_all("number = number - 1")
  end

  def self.downloadable
    where(downloadable: true)
  end

  def self.streamable
    where.not(audio: nil)
  end

end
