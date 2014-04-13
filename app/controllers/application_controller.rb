class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :expose_tweets

  protected

  def expose_tweets
    @tweets = Tweet.recent.page(params[:page]).per(7)
  end

end