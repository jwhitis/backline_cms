class UserMailerPreview < ActionMailer::Preview

  def new_account_email
    UserMailer.new_account_email(User.first)
  end

  def new_site_email
    UserMailer.new_site_email(User.first)
  end

end