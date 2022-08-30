require "test_helper"

class UserLoginTest < ActionDispatch::IntegrationTest

  def setup
    @admin_user = users(:zvjezdana)
    @other_user = users(:other)
  end

  test "login as admin with valid username/password" do
    get login_path
    assert_template 'sessions/new'
    assert_select 'form#login-form'
    post login_path, params: { session: { username: @admin_user.username,
                                          password: 'zvjezdana' } }
    assert is_logged_in?
    assert_equal cookies[:remember_token], assigns(:user).remember_token
    assert_redirected_to root_url
    follow_redirect!
    assert_template 'clients/index'
    assert_select "a[href=?]", logout_path
    assert_select 'h2', text: 'Novi klijent'
    assert_select 'form#add-client'
  end

  test "login as non-admin user" do
    get login_path
    post login_path, params: { session: { username: @other_user.username,
                                          password: 'other' } }
    refute is_logged_in?
    assert_nil cookies[:remember_token]
    refute flash.empty?
    assert_template 'sessions/new'
    assert_select 'form#login-form'
  end

  test "login with valid admin username/invalid password" do
    get login_path
    post login_path, params: { session: { username: @admin_user.username,
                                          password: 'password' } }
    refute is_logged_in?
    refute flash.empty?
    assert_template 'sessions/new'
  end

  test "login with invalid information" do
    get login_path
    post login_path, params: { session: { username: '', password: '' } }
    refute is_logged_in?
    refute flash.empty?
    assert_template 'sessions/new'
  end
end
