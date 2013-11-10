class PagesController < ApplicationController
  respond_to :js, :html
  before_action :expose_tweets

  TWITTER_HANDLES = ["ToddFarrellJr", "SomeCallMeGoose", "EliRhodes", "jwhitis"]

  def shows
    @shows = Show.order(:date)
  end

  def releases
  end

  def media
  end

  def bio
  end

  private

  def expose_tweets
    @tweets = []
    TWITTER_HANDLES.each { |handle| @tweets.concat Twitter.user_timeline(handle) }
    @tweets = @tweets.sort_by(&:created_at).reverse!.take(8)
  end

end