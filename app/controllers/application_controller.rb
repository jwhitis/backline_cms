class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :expose_tweets

  TWITTER_HANDLES = ["ToddFarrellJr", "SomeCallMeGoose", "EliRhodes", "jwhitis"]

  def expose_tweets
    unless request.xhr?
      @tweets = []
      TWITTER_HANDLES.each { |handle| @tweets.concat Twitter.user_timeline(handle) }
      @tweets = @tweets.sort_by(&:created_at).reverse!.take(7)
    end
  end

end