require "application_system_test_case"

class UserOpensClientsTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit user_opens_clients_url
  #
  #   assert_selector "h1", text: "UserOpensClient"
  # end

  test "open client page" do
    client = clients(:two)

    visit root_url
    fill_in('Korisničko ime', with: 'zvjezdana')
    fill_in('Lozinka', with: 'zvjezdana')
    click_button('Prijavi se')

    assert_selector "div.client-list-item"
    first("a[href='#{client_path(client.id)}']").click

    assert_selector "h2", text: "Novi tretman"
    assert_no_selector "div.pagination"
    assert_selector "ol.treatments"
    assert_selector "ol.treatments li", count: client.treatments.count

    assert_equal treatments(:four).date.strftime("%d.%m.%Y."),
          first("ol.treatments li .treatment-info .treatment-date")['innerText']
  end
end
