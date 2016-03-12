class TweetRefresher
  # This implementation is only suitable for a low number of sites.
  # To improve performance, it should be replaced with a strategy that
  # authorizes the individual site and runs in a background process.
  LIMIT = 30 # This number is set arbitrarily to prevent rate limiting.

  class << self

    def refresh_all
      sites = Site.with_twitter_feed.order(:id)
      @offset = sites.offset(@offset).any? ? @offset : 0
      sites = sites.offset(@offset).limit(LIMIT)
      @offset = @offset.to_i + LIMIT

      sites.each { |site| refresh(site.id) }
    end

    def refresh site_id
      Site.current_id = site_id

      tweets = new_tweets(twitter_client)
      return if tweets.empty?

      params = tweets.map { |tweet| tweet_params(tweet) }
      Tweet.create!(params)
      Tweet.outdated.destroy_all
    ensure
      Site.current_id = nil
    end

    private

    def twitter_client
      Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
        config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
        config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
      end
    end

    def new_tweets client
      options = { count: Tweet::COUNT, exclude_replies: true }
      options[:since_id] = Tweet.maximum(:twitter_id) if Tweet.maximum(:twitter_id)
      tweets = []

      TwitterHandle.pluck(:handle).each do |handle|
        user_tweets = client.user_timeline(handle, options)
        tweets.concat(user_tweets)
      end

      tweets.sort_by(&:created_at).reverse.take(Tweet::COUNT)
    end

    def tweet_params tweet
      params = {
        name: tweet.user.name,
        handle: tweet.user.screen_name,
        profile_url: tweet.user.url.to_s,
        image_url: tweet.user.profile_image_url(:original).to_s,
        text: tweet.text,
        posted_at: tweet.created_at,
        twitter_id: tweet.id
      }

      ActionController::Parameters.new(params).permit!
    end

  end
end