class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :find_site
  before_action :find_nav_links
  before_action :find_tweets

  helper_method :feature_active?, :home_page_path, :current_role, :user_signed_in?,
                :admin_signed_in?

  protected

  def find_site
    @site = Backline.site
  end

  def find_nav_links
    @nav_links = NavLink.with_accessible_url.display_order.includes(:page)
  end

  def find_tweets
    @tweets = Tweet.display_order.limit(7) if feature_active?(:twitter_feed)
  end

  def find_page
    slug = request.path.sub(/\A\//, "")
    @page = Page.published.find_by_slug!(slug)
  end

  def verify_feature_active!
    unless feature_active?(feature_name)
      render file: "#{Rails.root}/public/404", layout: false, status: :not_found
      return
    end
  end

  def feature_active? name
    if Feature::NAMES.exclude?(name.to_s)
      raise ArgumentError, "#{name} is not a valid feature."
    end

    @site.feature_names.include?(name.to_s)
  end

  def feature_name
    controller_name
  end

  def verify_subscriber_exists!
    if feature_active?(:mailing_list) && !subscriber_exists?
      if request.xhr?
        @page = Page.find_by_slug!("exclusive-content")
        @subscriber = Subscriber.new
        params[:request_path] = request.fullpath
        render "subscribers/new"
      else
        redirect_to new_subscriber_path(request_path: request.fullpath)
      end
    end
  end

  def subscriber_exists?
    !!cookies.signed[:subscriber_id]
  end

  def home_page_path
    @site.home_page.path
  end

  def current_session
    return @current_session if defined?(@current_session)
    @current_session = Session.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_session && current_session.user
  end

  def current_role
    return @current_role if defined?(@current_role)
    @current_role = current_user && current_user.roles.find_by_site_id!(@site.id)
  end

  def user_signed_in?
    !!current_session
  end

  def authenticate_user!
    unless user_signed_in?
      if request.xhr?
        @session = Session.new
        render "sessions/new"
      else
        redirect_to sign_in_path
      end
    end
  end

  def authorize_user!
    unless authorized_roles.include?(current_role.name)
      flash[:alert] = "You are not authorized to access the page you requested."

      if request.xhr?
        render js: "location = '#{home_page_path}';"
      else
        redirect_to home_page_path
      end
    end
  end

  def authorized_roles
    Role::NAMES
  end

  def admin_signed_in?
    user_signed_in? && Role::ADMIN_NAMES.include?(current_role.name)
  end

  def self.feature_name name
    name = name.to_s
    define_method(:feature_name) { name }
  end

  def self.authorized_roles *roles
    roles.map!(&:to_s)
    define_method(:authorized_roles) { roles }
  end

end