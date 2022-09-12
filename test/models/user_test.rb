require "test_helper"

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(username: 'pero',
                     password: 'pero',
                     password_confirmation: 'pero')
  end
  
  test "should be valid" do
    assert @user.valid?
  end

  test "username should be present" do
    @user.username = "     "
    refute @user.valid?
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    refute @user.valid?
  end

  test "username should be unique" do
    duplicate_user = @user.dup
    @user.save
    refute duplicate_user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    refute @user.authenticated?("")
  end

end
