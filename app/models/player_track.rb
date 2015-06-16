class PlayerTrack < Track
  validates_presence_of :audio

  before_validation :set_number
  after_destroy :decrement_track_numbers!

  def set_number
    self.number ||= PlayerTrack.count + 1
  end

  def decrement_track_numbers!
    tracks = PlayerTrack.where("number > ?", self.number)
    tracks.update_all("number = number - 1")
  end

  def self.audio_urls
    display_order.map { |track| track.audio.url }
  end

  def self.titles
    display_order.pluck(:title)
  end

end
