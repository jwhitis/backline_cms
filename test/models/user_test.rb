require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup :initialize_user

  test "validates format of #email" do
    @user.email = "invalid"
    assert_not @user.save
    assert_includes @user.errors.full_messages, "Email is invalid"
  end

  test "validates length of #email" do
    100.times { @user.email.prepend("a") }
    assert_not @user.save
    assert_includes @user.errors.full_messages, "Email is too long (maximum is 100 characters)"
  end

  test "validates uniqueness of #email" do
    new_user = User.new(email: @user.email, password: "password", password_confirmation: "password")
    assert_not new_user.save
    assert_includes new_user.errors.full_messages, "Email has already been taken"
  end

  test "validates length of #password" do
    @user.password = "abc"
    assert_not @user.save
    assert_includes @user.errors.full_messages, "Password is too short (minimum is 4 characters)"
  end

  test "validates that #password and #password_confirmation match" do
    @user.password = "password"
    @user.password_confirmation = "wordpass"
    assert_not @user.save
    assert_includes @user.errors.full_messages, "Password confirmation must match password"
  end

  private

  def initialize_user
    @user = users(:default)
  end

end
