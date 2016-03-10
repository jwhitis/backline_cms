class Show < ActiveRecord::Base
  include SiteScope

  validates_presence_of :venue_name, :date, :city, :state
  validates :venue_url, url: true, allow_blank: true
  validates :tickets_url, url: true, allow_blank: true

  def location
    "#{self.city}, #{self.state}"
  end

  def self.display_order
    order(date: :desc)
  end

  def self.published
    where(published: true)
  end

end
