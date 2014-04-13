class Tweet < ActiveRecord::Base

  MAX_SAVED = 100

  def self.outdated
    recent.offset(MAX_SAVED)
  end

  def self.recent
    order(:posted_at).reverse_order
  end

end
