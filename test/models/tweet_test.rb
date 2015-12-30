require 'test_helper'

class TweetTest < ActiveSupport::TestCase
  setup :initialize_tweet
  teardown :reload_singleton

  test "Tweet#newest_twitter_id returns the Twitter ID of the newest tweet" do
    assert_equal Tweet.maximum(:twitter_id), Tweet.newest_twitter_id
  end

  test "Tweet#newest_twitter_id memoizes the Twitter ID" do
    Tweet.newest_twitter_id
    Tweet.create!(newest_tweet_attributes)
    assert_not_equal Tweet.maximum(:twitter_id), Tweet.newest_twitter_id
  end

  test "Tweet#reload forces the Twitter ID to be reloaded" do
    Tweet.newest_twitter_id
    Tweet.create!(newest_tweet_attributes)
    Tweet.reload
    assert_equal Tweet.maximum(:twitter_id), Tweet.newest_twitter_id
  end

  test "Tweet#display_order returns newest tweets first" do
    assert_equal tweets(:first), Tweet.display_order.first
    assert_equal tweets(:last), Tweet.display_order.last
  end

  test "Tweet#outdated returns old tweets after a certain number" do
    original_count = Tweet::COUNT
    silence_warnings { Tweet::COUNT = 1 }
    assert_includes Tweet.outdated, tweets(:last)
    assert_not_includes Tweet.outdated, tweets(:first)
    silence_warnings { Tweet::COUNT = original_count }
  end

  private

  def initialize_tweet
    @tweet = tweets(:default)
  end

  def reload_singleton
    Tweet.reload
  end

  def newest_tweet_attributes
    twitter_id = Tweet.maximum(:twitter_id) + 1
    @tweet.attributes.except("id").merge("twitter_id" => twitter_id)
  end

end