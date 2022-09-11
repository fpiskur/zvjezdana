require "test_helper"

class TreatmentsAddTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:zvjezdana)
    @client = clients(:one)
  end

  test "create treatment with invalid information" do
    flash_msg_default = "Nije moguće dodati novi tretman!"
    log_in_as(@user)

    # invalid date and description
    assert_no_difference '@client.treatments.count' do
      post client_treatments_path(@client), params: { treatment: {
                                                        date: "",
                                                        description: "" } }
    end
    assert_redirected_to client_url(@client)
    follow_redirect!
    refute flash.empty?
    assert_select 'div.alert-danger', text: "#{flash_msg_default} - "\
            "polje Opis ne može biti prazno i polje Datum ne može biti prazno"

    # invalid date / valid description
    assert_no_difference '@client.treatments.count' do
      post client_treatments_path(@client), params: { treatment: {
                                                        date: "",
                                                        description: "test" } }
    end
    assert_redirected_to client_url(@client)
    follow_redirect!
    refute flash.empty?
    assert_select 'div.alert-danger', text: "#{flash_msg_default} - "\
            "polje Datum ne može biti prazno"

    # valid date / invalid description
    assert_no_difference '@client.treatments.count' do
      post client_treatments_path(@client), params: { treatment: {
                                                        date: "2022-05-24",
                                                        description: "" } }
    end
    assert_redirected_to client_url(@client)
    follow_redirect!
    refute flash.empty?
    assert_select 'div.alert-danger', text: "#{flash_msg_default} - "\
            "polje Opis ne može biti prazno"
  end

  test "create treatment with valid information" do
    log_in_as(@user)
    treatment = Treatment.new(date: "2022-05-24", description: "testing")
    assert_difference '@client.treatments.count', 1 do
      post client_treatments_path(@client), params: { treatment: {
                                          date: treatment.date,
                                          description: treatment.description } }
    end
    treatment = assigns(:treatment)
    assert_redirected_to client_url(@client)
    follow_redirect!
    refute flash.empty?
    assert_select 'div.alert-success', text: "Novi tretman je dodan!"
    assert_select "li#treatment-#{treatment.id}"
  end

end
