class PasswordResetMailer < ApplicationMailer
  helper :users

  def password_reset_email user
    @user = user
    @site = Backline.site
    mail(to: @user.email, subject: "Password reset instructions")
  end

end