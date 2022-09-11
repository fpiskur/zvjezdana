require "application_system_test_case"

class UserDeletesTreatmentsTest < ApplicationSystemTestCase
  
  def setup
    @client = clients(:two)
    @treatment = treatments(:two)
    log_in_admin
  end

  test "delete treatment" do
    assert_selector "li#client-#{@client.id}"
    visit client_path(@client)
    assert_selector "li#treatment-#{@treatment.id}"
    accept_confirm do
      first("li#treatment-#{@treatment.id} a[data-turbo-method='delete']").click
    end
    assert_selector "div.alert-success", text: "Tretman je izbrisan!"
    assert_selector "ol.treatments"
    assert_no_selector "li#treatment-#{@treatment.id}"
  end

  test "abort deleting treatment" do
    assert_selector "li#client-#{@client.id}"
    visit client_path(@client)
    assert_selector "li#treatment-#{@treatment.id}"
    dismiss_confirm do
      first("li#treatment-#{@treatment.id} a[data-turbo-method='delete']").click
    end
    assert_selector "ol.treatments"
    assert_selector "li#treatment-#{@treatment.id}"
  end

end
