class Admin::TweetsController < Admin::AdminController

  def refresh
    TweetRefresher.refresh
    find_tweets
    flash.now[:notice] = "Tweets successfully refreshed."
  rescue Twitter::Error::TooManyRequests
    flash.now[:notice] = "Please wait 15 minutes and try again."
  end

end