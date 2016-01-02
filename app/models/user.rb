class User < ActiveRecord::Base
  has_many :roles, dependent: :destroy

  acts_as_authentic do |config|
    config.merge_validates_format_of_email_field_options(message: "is invalid")
    config.merge_validates_confirmation_of_password_field_options(message: "must match password")
  end
end
