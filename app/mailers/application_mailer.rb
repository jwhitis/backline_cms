class ApplicationMailer < ActionMailer::Base
  before_action :find_site
  default from: "no-reply@backlinecms.com"
  layout "mailer"

  protected

  def find_site
    @site = Site.find(Site.current_id)
  end

end