class AlbumTrack < Track
  belongs_to :album, counter_cache: :tracks_count

  validates_presence_of :album_id

  before_validation :set_downloadable

  def set_downloadable
    self.downloadable = false if self.remove_audio?
    true # Object becomes invalid if a callback returns false
  end

  def order_scope
    { album: self.album }
  end

  def self.downloadable
    where(downloadable: true)
  end

  def self.streamable
    where.not(audio: nil)
  end

end
