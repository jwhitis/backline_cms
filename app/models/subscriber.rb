class Subscriber < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :country
  validates :zip, presence: true, zip: true, if: :country_is_us?
  validates :email, presence: true, email: true, uniqueness: true

  def country_is_us?
    self.country == "US"
  end

end
