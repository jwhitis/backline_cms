require "csv"

class Subscriber < ActiveRecord::Base
  PROFILE_ATTRIBUTES = [:first_name, :last_name, :country]

  attr_accessor :validate_profile

  validates_presence_of *PROFILE_ATTRIBUTES, if: :validate_profile
  validates :email, presence: true, email: true, uniqueness: { case_sensitive: false }

  def exclusive_content?
    PROFILE_ATTRIBUTES.all? { |attribute| self.send(attribute) }
  end

  def exclusive_content_in_words
    exclusive_content? ? "Yes" : "No"
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.display_order
    order(created_at: :desc)
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << ["Added", "Name", "Email Address", "Country", "Postal Code", "Exclusive Content?"]

      all.each do |subscriber|
        row = []
        row << subscriber.created_at.to_s(:numeric)
        row << subscriber.full_name
        row << subscriber.email
        row << ISO3166::Country[subscriber.country].try(:name)
        row << subscriber.zip
        row << subscriber.exclusive_content_in_words
        csv << row
      end
    end
  end

end
