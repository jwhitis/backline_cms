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

end
