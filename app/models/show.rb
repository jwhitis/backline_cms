class Show < ActiveRecord::Base
  validates_presence_of :venue, :date

  def pretty_date
    (date || Date.today).strftime("%-m-%-d-%Y")
  end

  def pretty_address
    "#{address}<br />#{city}, #{state} #{zip}"
  end

end
