require "application_system_test_case"

class UserOpensClientsTest < ApplicationSystemTestCase

  def setup
    @client = clients(:two)
    log_in_admin
  end

  test "open client page" do
    assert_selector "div.client-list-item"
    first("a[href='#{client_path(@client.id)}']").click

    assert_selector "h2", text: "Novi tretman"
    assert_no_selector "div.pagination"
    assert_selector "ol.treatments"
    assert_selector "ol.treatments li", count: @client.treatments.count

    assert_equal treatments(:four).date.strftime("%d.%m.%Y."),
          first("ol.treatments li .treatment-info .treatment-date")['innerText']
  end

end
