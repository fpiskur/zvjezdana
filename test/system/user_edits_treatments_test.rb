require "application_system_test_case"

class UserEditsTreatmentsTest < ApplicationSystemTestCase
  
  def setup
    @client = clients(:two)
    @treatment = treatments(:two)
    log_in_admin
  end

  test "edit treatment" do
    assert_selector "li#client-#{@client.id}"
    visit client_path(@client)
    find("li#treatment-#{@treatment.id}").click_link('uredi')
    assert_selector "form#edit-treatment"
    assert_equal @treatment.date.strftime("%Y-%m-%d"),
                 find("input[name='treatment[date]']").value
    assert_equal @treatment.description,
                 find("input[name='treatment[description]']").value
    assert_selector "button.back-btn"
    click_button('NATRAG')
    assert_current_path(client_path(@client))
  end

end
