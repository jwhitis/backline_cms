class TweetRefresher
  class << self

    def refresh
      tweets = new_tweets(twitter_client)
      return if tweets.empty?

      params = tweets.map { |tweet| tweet_params(tweet) }
      Tweet.create!(params)
      Tweet.outdated.destroy_all
      Tweet.reload
    end

    private

    def twitter_client
      Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['TWITTER_KEY']
        config.consumer_secret     = ENV['TWITTER_SECRET']
        config.access_token        = ENV['ACCESS_TOKEN']
        config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
      end
    end

    def new_tweets client
      options = { count: Tweet::COUNT, exclude_replies: true }
      options[:since_id] = Tweet.newest_twitter_id if Tweet.newest_twitter_id
      tweets = []

      TwitterHandle.handles.each do |handle|
        user_tweets = client.user_timeline(handle, options)
        tweets.concat(user_tweets)
      end

      tweets.sort_by(&:created_at).reverse.take(Tweet::COUNT)
    end

    def tweet_params tweet
      params = raw_params(tweet)
      ActionController::Parameters.new(params).permit!
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