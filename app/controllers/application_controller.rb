class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :expose_tweets

  protected

  def expose_tweets
    @tweets = Tweet.display_order.limit(7)
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
    !!session[:subscriber_email]
  end

end