require 'test_helper'

class TwitterHandleTest < ActiveSupport::TestCase
  setup :initialize_twitter_handle
  teardown :reload_singleton

  test "validates presence of #handle" do
    @twitter_handle.handle = nil
    assert_not @twitter_handle.save
    assert_includes @twitter_handle.errors.full_messages, "Username can't be blank"
  end

  test "TwitterHandle#handles returns an array of handles" do
    assert_instance_of Array, TwitterHandle.handles
    assert_includes TwitterHandle.handles, @twitter_handle.handle
  end

  test "TwitterHandle#handles memoizes the handles" do
    TwitterHandle.handles
    TwitterHandle.create!(handle: "new_handle")
    assert_not_equal TwitterHandle.pluck(:handle), TwitterHandle.handles
  end

  test "TwitterHandle#reload forces the handles to be reloaded" do
    TwitterHandle.handles
    TwitterHandle.create!(handle: "new_handle")
    TwitterHandle.reload
    assert_equal TwitterHandle.pluck(:handle), TwitterHandle.handles
  end

  test "TwitterHandle#display_order returns oldest Twitter handles first" do
    assert_equal twitter_handles(:first), TwitterHandle.display_order.first
    assert_equal twitter_handles(:last), TwitterHandle.display_order.last
  end

  private

  def initialize_twitter_handle
    @twitter_handle = twitter_handles(:default)
  end

  def reload_singleton
    TwitterHandle.reload
  end

end