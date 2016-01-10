class PasswordResetMailerPreview < ActionMailer::Preview

  def password_reset_email
    PasswordResetMailer.password_reset_email(User.first)
  end

end