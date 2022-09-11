require "test_helper"

class TreatmentsEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:zvjezdana)
    @client = clients(:one)
    @treatment = treatments(:one)
  end

  test "edit treatment with invalid information" do
    flash_msg_default = "Nije moguće urediti novi tretman!"
    log_in_as(@user)

    # invalid date and description
    patch client_treatment_path(@client, @treatment), params: { treatment: {
                                                        date: "  ",
                                                        description: "  " } }
    assert_template 'edit'
    refute flash.empty?
    assert_select 'div.alert-danger', text: "#{flash_msg_default} - "\
              "polje Opis ne može biti prazno i polje Datum ne može biti prazno"
    refute @treatment.reload.date.blank? || @treatment.reload.description.blank?
  end

  test "edit treatment with valid information" do
    log_in_as(@user)
    patch client_treatment_path(@client, @treatment), params: { treatment: {
                                                        date: "2022-05-24",
                                                        description: "foo" } }
    assert_redirected_to client_path(@client)
    follow_redirect!
    refute flash.empty?
    assert_select 'div.alert-success', text: "Izmjene su spremljene!"
    assert_equal "foo", @treatment.reload.description
  end

end
