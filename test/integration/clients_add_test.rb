require "test_helper"

class ClientsAddTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:zvjezdana)
  end
  
  test "invalid client information" do
    log_in_as(@user)
    assert_no_difference 'Client.count' do
      post clients_path, params: { client: { first_name: "   ",
                                             last_name: "   ",
                                             phone_num: "",
                                             comment: "" } }
    end
    assert_redirected_to root_url
    follow_redirect!
    refute flash.empty?
    assert_select 'div.alert-danger', text: "Greška prilikom dodavanja novog "\
                  "klijenta! - Ispunite barem jedno od polja - Ime ili Prezime."
  end

end
