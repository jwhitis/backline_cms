class Tweet < ActiveRecord::Base
  MAX_SAVED = 50

  def self.display_order
    order(posted_at: :desc)
  end

  def self.outdated
    order(posted_at: :desc).offset(MAX_SAVED)
  end

end
