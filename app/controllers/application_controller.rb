class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :expose_tweets

  TWITTER_HANDLES = ["ToddFarrellJr", "SomeCallMeGoose", "EliRhodes", "jwhitis"]

  protected

  def expose_tweets
    @tweets = sorted_tweets.take(7) unless request.xhr?
  end

  def sorted_tweets
    tweets = []
    TWITTER_HANDLES.each { |handle| tweets.concat twitter_client.user_timeline(handle) }
    tweets.sort_by(&:created_at).reverse
  end

  def twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_KEY']
      config.consumer_secret = ENV['TWITTER_SECRET']
      config.access_token = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end
  end

end