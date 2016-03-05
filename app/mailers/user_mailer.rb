class UserMailer < ApplicationMailer

  def new_account_email user
    @user = user
    @site = Backline.site
    mail(to: @user.email, subject: "Welcome to Backline CMS")
  end

  def new_site_email user
    @user = user
    @site = Backline.site
    mail(to: @user.email, subject: "You've been added to a new site")
  end

end