class TweetRefresher

  TWITTER_HANDLES = ["ToddFarrellJr", "SomeCallMeGoose", "EliRhodes", "jwhitis"]

  class << self

    def refresh
      tweets.each do |tweet|
        Tweet.create(tweet_params(tweet)) unless Tweet.find_by_twitter_id(tweet.id)
      end
      Tweet.outdated.destroy_all
    end

    private

    def tweet_params tweet
      params = ActionController::Parameters.new(raw_params(tweet))
      params.permit!
    end

    def raw_params tweet
      {
        screen_name: tweet.user.screen_name,
        profile_image_url: tweet.user.profile_image_url.to_s,
        text: tweet.text,
        posted_at: tweet.created_at,
        twitter_id: tweet.id
      }
    end

    def tweets
      tweets = []
      TWITTER_HANDLES.each do |handle|
        tweets.concat twitter_client.user_timeline(handle)
      end
      tweets
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

end