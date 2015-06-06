class Admin::TweetsController < Admin::AdminController
  respond_to :js

  def refresh
    TweetRefresher.refresh
    expose_tweets
    flash.now[:notice] = "Tweets successfully refreshed."
  rescue Twitter::Error::TooManyRequests
    flash.now[:notice] = "Please wait 15 minutes and try again."
  end

end