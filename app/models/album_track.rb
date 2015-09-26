class AlbumTrack < Track
  belongs_to :album, counter_cache: :tracks_count

  validates_presence_of :album_id
  validate :must_have_audio_to_be_downloadable

  before_validation :set_downloadable

  def must_have_audio_to_be_downloadable
    if self.downloadable? && self.audio.blank?
      self.errors[:base] << "Track must have audio to be downloadable"
    end
  end

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
