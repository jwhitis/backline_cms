require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  setup :initialize_video

  test "validates presence of #title" do
    @video.title = nil
    assert_not @video.save
    assert_includes @video.errors.full_messages, "Title can't be blank"
  end

  test "validates presence of #embed" do
    @video.embed = nil
    assert_not @video.save
    assert_includes @video.errors.full_messages, "Embed can't be blank"
  end

  test "Video#display_order returns newest videos first" do
    assert_equal videos(:first), Video.display_order.first
    assert_equal videos(:last), Video.display_order.last
  end

  test "Video#published returns only published videos" do
    assert_includes Video.published, @video
    assert_not_includes Video.published, videos(:unpublished)
  end

  private

  def initialize_video
    @video = videos(:default)
  end

end