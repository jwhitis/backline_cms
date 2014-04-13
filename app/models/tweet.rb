class Tweet < ActiveRecord::Base
  MAX_SAVED = 50

  def self.outdated
    recent.offset(MAX_SAVED)
  end

  def self.recent
    order("posted_at DESC")
  end

end
