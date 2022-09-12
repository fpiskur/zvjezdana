require "application_system_test_case"

class UserEditsClientsTest < ApplicationSystemTestCase
  
  def setup
    @client = clients(:two)
    log_in_admin
  end

  test "edit client" do
    first("a[href='#{client_path(@client.id)}']").click
    assert_selector "a.edit-client-btn"
    click_link("uredi klijenta")
    assert_selector "form#edit-client"
    assert_equal @client.first_name,
                 find("input[name='client[first_name]']").value
    assert_equal @client.last_name,
                 find("input[name='client[last_name]']").value
    assert_equal @client.phone_num,
                 find("input[name='client[phone_num]']").value
    assert_equal @client.comment,
                 find("textarea[name='client[comment]']").value
    assert_selector "button.back-btn"
    click_button("NATRAG")
    assert_current_path(client_path(@client))
  end

end
