class Admin::TweetsController < Admin::AdminController
  before_action :verify_feature_active!
  feature_name :twitter_feed

  def refresh
    TweetRefresher.refresh(Site.current_id)
    find_tweets
    flash.now[:notice] = "Tweets successfully refreshed."
  rescue Twitter::Error::TooManyRequests
    flash.now[:notice] = "Please wait 15 minutes and try again."
  end

end