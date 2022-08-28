require "test_helper"

class ClientsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @admin_user = users(:zvjezdana)
    @other_user = users(:other)
  end

  test "should redirect index when not logged in" do
    get root_path
    assert_redirected_to login_path
  end

end
