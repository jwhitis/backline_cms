class PasswordResetMailer < ApplicationMailer

  def password_reset_email user
    @user = user
    @site = Backline.site
    mail(to: @user.email, subject: "Password Reset Instructions")
  end

end