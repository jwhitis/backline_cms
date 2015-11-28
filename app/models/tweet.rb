class Tweet < ActiveRecord::Base
  COUNT = 20 # Must be less than or equal to 200

  def self.newest_twitter_id
    return @newest_twitter_id if defined?(@newest_twitter_id)
    @newest_twitter_id = maximum(:twitter_id)
  end

  def self.reload
    remove_instance_variable(:@newest_twitter_id) if defined?(@newest_twitter_id)
  end

  def self.display_order
    order(posted_at: :desc)
  end

  def self.outdated
    order(posted_at: :desc).offset(COUNT)
  end

end
