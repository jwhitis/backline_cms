require 'test_helper'

class TwitterHandleTest < ActiveSupport::TestCase
  setup :initialize_twitter_handle

  test "validates presence of #handle" do
    @twitter_handle.handle = nil
    assert_not @twitter_handle.save
    assert_includes @twitter_handle.errors.full_messages, "Username can't be blank"
  end

  test "TwitterHandle#display_order returns oldest Twitter handles first" do
    assert_equal twitter_handles(:first), TwitterHandle.display_order.first
    assert_equal twitter_handles(:last), TwitterHandle.display_order.last
  end

  private

  def initialize_twitter_handle
    @twitter_handle = twitter_handles(:default)
  end

end