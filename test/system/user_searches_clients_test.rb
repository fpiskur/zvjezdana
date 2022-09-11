require "application_system_test_case"

class UserSearchesClientsTest < ApplicationSystemTestCase

  def setup
    log_in_admin
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
    find("input#query").fill_in with: "client"
    page.execute_script("document.querySelector('div#search-clients form').submit()")
    assert_selector "ul.clients li", count: 50
    assert_selector "div.pagination", count: 2
    first("a", text: "2").click
    assert_selector "ul.clients li", count: 50
    assert_selector "div.pagination", count: 2
  end

  test "search client by first name" do
    find("input#query").fill_in with: "ivo"
    page.execute_script("document.querySelector('div#search-clients form').submit()")
    assert_selector "ul.clients li", count: 3
    assert_no_selector "div.pagination"
  end

  test "search client by last name" do
    find("input#query").fill_in with: "ivi"
    page.execute_script("document.querySelector('div#search-clients form').submit()")
    assert_selector "ul.clients li", count: 3
    assert_no_selector "div.pagination"
  end

  test "search for non-existent client" do
    find("input#query").fill_in with: "qwertz"
    page.execute_script("document.querySelector('div#search-clients form').submit()")
    assert_no_selector "ul.clients li"
    assert_no_selector "div.pagination"
  end

end
