class PasswordResetMailer < ApplicationMailer
  helper :users

  def password_reset_email user
    @user = user
    mail(to: @user.email, subject: "Password reset instructions")
  end

end