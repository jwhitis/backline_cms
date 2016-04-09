class ApplicationMailer < ActionMailer::Base
  before_action :find_site
  default from: "no-reply@backlinecms.com"
  layout "mailer"

  protected

  def find_site
    @site = Site.find_by_id(Site.current_id) || Site.find_by_subdomain!("www")
  end

end