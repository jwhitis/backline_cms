class Tweet < ActiveRecord::Base
  include SiteScope

  COUNT = 20 # Must be less than or equal to 200

  def self.display_order
    order(posted_at: :desc)
  end

  def self.outdated
    order(posted_at: :desc).offset(COUNT)
  end

end
