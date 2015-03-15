class Show < ActiveRecord::Base
  validates_presence_of :venue_name, :date, :city, :state

  def pretty_date
    (date || Date.today).strftime("%-m-%-d-%Y")
  end

  def pretty_address
    "#{address}#{"<br />" if address.present?}#{city}#{"," if city.present?} #{state} #{zip}"
  end

  def self.upcoming
    published.where("date >= ?", Date.today).order(:date)
  end

  def self.past
    published.where("date < ?", Date.today).order("date DESC")
  end

  def self.published
    where(published: true)
  end

end
