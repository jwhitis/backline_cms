class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :find_site
  before_action :find_nav_links
  before_action :find_tweets

  protected

  def find_site
    @site = Backline.site
  end

  def find_nav_links
    @nav_links = NavLink.display_order.includes(:page)
  end

  def find_tweets
    @tweets = Tweet.display_order.limit(7)
  end

  def find_page
    slug = request.path.sub(/\A\//, "")
    @page = Page.published.find_by_slug!(slug)
  end

  def admin_signed_in?
    !!session[:admin_id]
  end
  helper_method :admin_signed_in?

  def verify_subscription!
    unless user_subscribed?
      redirect_to new_subscriber_path(request_path: request.fullpath)
    end
  end

  def user_subscribed?
    !!cookies.signed[:subscriber_id]
  end

end