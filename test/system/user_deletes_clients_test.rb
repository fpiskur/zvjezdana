require "application_system_test_case"

class UserDeletesClientsTest < ApplicationSystemTestCase
  
  def setup
    @client = clients(:two)

    # Log in user
    visit root_url
    fill_in('Korisničko ime', with: 'zvjezdana')
    fill_in('Lozinka', with: 'zvjezdana')
    click_button('Prijavi se')
  end

  test "delete client" do
    assert_selector "li#client-#{@client.id}"
    accept_confirm do
      first("li#client-#{@client.id} span.client-controls a").click
    end
    assert_selector "div.alert-success", text: "Klijent je izbrisan!"
    assert_selector "ul.clients"
    assert_no_selector "li#client-#{@client.id}"
  end

end
