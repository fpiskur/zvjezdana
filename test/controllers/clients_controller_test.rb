require "test_helper"

class ClientsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @client = clients(:one)
  end

  test "should redirect index when not logged in" do
    get root_path
    refute flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect show when not logged in" do
    get client_path(@client)
    refute flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Client.count' do
      post clients_path, params: { client: { first_name: "Test" } }
    end
    refute flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when not logged in" do
    get edit_client_path(@client)
    refute flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch client_path(@client), params: { client: { first_name: "Other" } }
    refute flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Client.count' do
      delete client_path(@client)
    end
    refute flash.empty?
    assert_redirected_to login_url
  end

end
