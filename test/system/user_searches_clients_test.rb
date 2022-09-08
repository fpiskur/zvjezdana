require "application_system_test_case"

class UserSearchesClientsTest < ApplicationSystemTestCase

  def setup
    # Log in user
    visit root_url
    fill_in('Korisničko ime', with: 'zvjezdana')
    fill_in('Lozinka', with: 'zvjezdana')
    click_button('Prijavi se')
  end

  test "empty search query" do
    assert_selector "input#query"
    assert_equal "", find("input#query").value
    page.execute_script("document.querySelector('div#search-clients form').submit()")
    assert_selector "ul.clients li", count: 50
    assert_selector "div.pagination", count: 2
  end

  test "search client with one result" do
    client = clients(:client_8)
    find("input#query").fill_in with: "#{client.first_name} #{client.last_name}"
    page.execute_script("document.querySelector('div#search-clients form').submit()")
    assert_selector "li#client-#{client.id}"
    assert_selector "ul.clients li", count: 1
    assert_no_selector "div.pagination"
  end

  test "search client with many results" do
    
  end

end
