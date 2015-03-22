class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :expose_tweets

  def admin_signed_in?
    !!session[:admin_id]
  end
  helper_method :admin_signed_in?

  def expose_tweets
    @tweets = Tweet.recent
  end

end