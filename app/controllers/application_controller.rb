class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :find_site
  before_action :find_nav_links
  before_action :find_tweets

  helper_method :feature_activated?, :home_page_path, :admin_signed_in?

  protected

  def find_site
    @site = Backline.site
  end

  def find_nav_links
    @nav_links = NavLink.with_accessible_url.display_order.includes(:page)
  end

  def find_tweets
    @tweets = Tweet.display_order.limit(7) if feature_activated?(:twitter_feed)
  end

  def find_page
    slug = request.path.sub(/\A\//, "")
    @page = Page.published.find_by_slug!(slug)
  end

  def verify_feature_activated!
    unless feature_activated?(feature_name)
      render file: "#{Rails.root}/public/404", layout: false, status: :not_found
      return
    end
  end

  def feature_activated? name
    if Feature::NAMES.exclude?(name.to_s)
      raise ArgumentError, "#{name} is not a valid feature."
    end

    @site.feature_names.include?(name.to_s)
  end

  def feature_name
    controller_name
  end

  def verify_user_subscribed!
    if feature_activated?(:mailing_list) && !user_subscribed?
      redirect_to new_subscriber_path(request_path: request.fullpath)
    end
  end

  def user_subscribed?
    !!cookies.signed[:subscriber_id]
  end

  def home_page_path
    home_page = @site.home_page
    "/#{home_page.slug}"
  end

  def admin_signed_in?
    !!session[:admin_id]
  end

end