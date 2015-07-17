class Subscriber < ActiveRecord::Base
  VALID_ZIP_REGEX = /\A\d{5}(?:-\d{4})?\z/
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates_presence_of :first_name, :last_name, :country
  validates :zip, presence: true, format: { with: VALID_ZIP_REGEX }, if: :country_is_us?
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true

  def country_is_us?
    self.country == "US"
  end

end
