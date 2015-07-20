class PlayerTrack < Track
  validates_presence_of :audio

  def self.audio_urls
    display_order.map { |track| track.audio.url }
  end

  def self.titles
    display_order.pluck(:title)
  end

end
