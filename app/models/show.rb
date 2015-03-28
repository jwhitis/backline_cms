class Show < ActiveRecord::Base
  validates_presence_of :venue_name, :date, :city, :state

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
