class User < ActiveRecord::Base
  has_many :roles, dependent: :destroy

  acts_as_authentic do |config|
    config.merge_validates_format_of_email_field_options(message: "is invalid")
    config.ignore_blank_passwords = false
    config.merge_validates_confirmation_of_password_field_options(message: "must match password")
    config.session_class = Session
  end

  def deliver_password_reset_email!
    reset_perishable_token!
    PasswordResetMailer.password_reset_email(self).deliver_now
  end

end
