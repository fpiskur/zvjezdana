require "test_helper"

class ClientsAddTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:zvjezdana)
    @client = clients(:one)
  end
  
  test "create client with invalid information" do
    log_in_as(@user)
    assert_no_difference 'Client.count' do
      post clients_path, params: { client: { first_name: "   ",
                                             last_name: "",
                                             phone_num: "",
                                             comment: "" } }
    end
    assert_redirected_to root_url
    follow_redirect!
    refute flash.empty?
    assert_select "div.alert-danger", text: "Greška prilikom dodavanja novog "\
                  "klijenta! - Ispunite barem jedno od polja - Ime ili Prezime."
  end

  test "create client with valid information" do
    log_in_as(@user)
    client = Client.new(first_name: "Test", last_name: "",
                        phone_num: "", comment: "")
    assert_difference 'Client.count', 1 do
      post clients_path, params: { client: { first_name: client.first_name,
                                             last_name: client.last_name,
                                             phone_num: client.phone_num,
                                             comment: client.comment } }
    end
    client = assigns(:client)
    assert_redirected_to client_path(client)
    follow_redirect!
    refute flash.empty?
    assert_select "div.alert-success", text: "Novi korisnik je dodan!"
    assert_select "p.client-name", text: "#{client.first_name}"
    assert_select "form#add-treatment"
  end

end
