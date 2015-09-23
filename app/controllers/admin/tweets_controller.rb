class Admin::TweetsController < Admin::AdminController
  before_action :verify_feature_activated!

  def refresh
    TweetRefresher.refresh
    find_tweets
    flash.now[:notice] = "Tweets successfully refreshed."
  rescue Twitter::Error::TooManyRequests
    flash.now[:notice] = "Please wait 15 minutes and try again."
  end

  private

  def feature_name
    "Twitter"
  end

end