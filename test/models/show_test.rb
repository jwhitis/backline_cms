require 'test_helper'

class ShowTest < ActiveSupport::TestCase
  setup :initialize_show

  test "validates presence of #venue_name" do
    @show.venue_name = nil
    assert_not @show.save
    assert_includes @show.errors.full_messages, "Venue name can't be blank"
  end

  test "validates presence of #date" do
    @show.date = nil
    assert_not @show.save
    assert_includes @show.errors.full_messages, "Date can't be blank"
  end

  test "validates presence of #city" do
    @show.city = nil
    assert_not @show.save
    assert_includes @show.errors.full_messages, "City can't be blank"
  end

  test "validates presence of #state" do
    @show.state = nil
    assert_not @show.save
    assert_includes @show.errors.full_messages, "State can't be blank"
  end

  test "validates format of #venue_url" do
    @show.venue_url = "invalid"
    assert_not @show.save
    assert_includes @show.errors.full_messages, "Venue URL is invalid"
  end

  test "allows #venue_url to be blank" do
    @show.venue_url = nil
    assert @show.save
  end

  test "validates format of #tickets_url" do
    @show.tickets_url = "invalid"
    assert_not @show.save
    assert_includes @show.errors.full_messages, "Tickets URL is invalid"
  end

  test "allows #tickets_url to be blank" do
    @show.tickets_url = nil
    assert @show.save
  end

  test "#location returns combined city and state" do
    assert_equal @show.location, "Nashville, TN"
  end

  test "Show#display_order returns last occurring shows first" do
    assert_equal Show.display_order.first, shows(:first)
    assert_equal Show.display_order.last, shows(:last)
  end

  test "Show#published returns only published shows" do
    assert_includes Show.published, @show
    assert_not_includes Show.published, shows(:unpublished)
  end

  private

  def initialize_show
    @show = shows(:default)
  end

end