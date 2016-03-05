class User < ActiveRecord::Base
  acts_as_authentic do |config|
    config.merge_validates_format_of_email_field_options(message: "is invalid")
    config.ignore_blank_passwords = false
    config.merge_validates_confirmation_of_password_field_options(message: "must match password")
    config.session_class = Session
  end

  has_many :roles, inverse_of: :user, dependent: :destroy
  has_many :sites, through: :roles

  accepts_nested_attributes_for :roles

  def current_role
    self.roles.find_by_site_id(Backline.site.id)
  end

  def new_account?
    self.current_login_at.nil?
  end

  def deliver_new_account_email!
    reset_perishable_token!
    UserMailer.new_account_email(self).deliver_now
  end

  def deliver_new_site_email!
    UserMailer.new_site_email(self).deliver_now
  end

  def deliver_password_reset_email!
    reset_perishable_token!
    PasswordResetMailer.password_reset_email(self).deliver_now
  end

  def self.display_order
    order(:email)
  end

end
