class TweetRefresher
  class << self

    def refresh
      tweets.each do |tweet|
        Tweet.create(tweet_params(tweet)) unless Tweet.exists?(twitter_id: tweet.id)
      end
      Tweet.outdated.destroy_all
    end

    private

    def tweets
      tweets = []
      twitter_handles.each do |handle|
        tweets.concat twitter_client.user_timeline(handle)
      end
      tweets.sort_by(&:created_at).reverse.take(Tweet::MAX_SAVED)
    end

    def twitter_handles
      TwitterHandle.pluck(:handle)
    end

    def twitter_client
      Twitter::REST::Client.new do |config|
        config.consumer_key = ENV['TWITTER_KEY']
        config.consumer_secret = ENV['TWITTER_SECRET']
        config.access_token = ENV['ACCESS_TOKEN']
        config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
      end
    end

    def tweet_params tweet
      params = ActionController::Parameters.new(raw_params(tweet))
      params.permit!
    end

    def raw_params tweet
      {
        name: tweet.user.name,
        handle: tweet.user.screen_name,
        profile_url: tweet.user.url.to_s,
        image_url: tweet.user.profile_image_url(:original).to_s,
        text: tweet.text,
        posted_at: tweet.created_at,
        twitter_id: tweet.id
      }
    end

  end
end