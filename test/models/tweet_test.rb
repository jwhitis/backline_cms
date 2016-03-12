require 'test_helper'

class TweetTest < ActiveSupport::TestCase
  setup :initialize_tweet

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

end