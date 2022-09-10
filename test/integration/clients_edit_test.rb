require "test_helper"

class ClientsEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:zvjezdana)
    @client = clients(:one)
  end

  test "edit client with invalid information" do
    log_in_as(@user)
    patch client_path(@client), params: { client: { first_name: "  ",
                                                         last_name: "  ",
                                                         phone_num: "",
                                                         comment: "" } }
    assert_template 'edit'
    refute flash.empty?
    assert_select 'div.alert-danger', text: "Greška prilikom uređivanja "\
              "klijenta! - Ispunite barem jedno od polja - Ime ili Prezime."
    refute @client.reload.first_name.empty?
  end

  test "edit client with valid information" do
    log_in_as(@user)
    patch client_path(@client), params: { client: { first_name: "Test",
                                                         last_name: "  ",
                                                         phone_num: "",
                                                         comment: "" } }
    assert_redirected_to client_path(@client)
    follow_redirect!
    refute flash.empty?
    assert_select 'div.alert-success', text: "Izmjene su spremljene!"
    assert_equal "Test", @client.reload.first_name
  end

end
