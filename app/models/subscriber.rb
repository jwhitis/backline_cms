require "csv"

class Subscriber < ActiveRecord::Base
  PROFILE_ATTRIBUTES = [:first_name, :last_name, :country]

  attr_accessor :validate_profile

  validates_presence_of *PROFILE_ATTRIBUTES, if: :validate_profile
  validates :email, presence: true, email: true, uniqueness: true

  def can_access_free_content?
    PROFILE_ATTRIBUTES.all? { |attribute| self.send(attribute) }
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.display_order
    order(created_at: :desc)
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << ["Added", "Name", "Email Address", "Country", "Postal Code", "Free Content?"]

      all.each do |subscriber|
        row = []
        row << subscriber.created_at.to_s(:numeric)
        row << subscriber.full_name
        row << subscriber.email
        row << ISO3166::Country[subscriber.country].try(:name)
        row << subscriber.zip
        row << subscriber.can_access_free_content? ? "Yes" : "No"
        csv << row
      end
    end
  end

end
