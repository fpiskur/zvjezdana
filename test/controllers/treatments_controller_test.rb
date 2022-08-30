require "test_helper"

class TreatmentsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @treatment = treatments(:one)
  end
  
  test "should redirect create when not logged in" do
    assert_no_difference 'Treatment.count' do
      post client_treatments_path(@treatment.client), params: {
                                      treatment: { date: "2022-06-20",
                                                   description: "something" } }
    end
    refute flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when not logged in" do
    get edit_client_treatment_path(@treatment.client, @treatment)
    refute flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch client_treatment_path(@treatment.client, @treatment), params: {
                                          treatment: { date: "2022-06-25",
                                                       description: "burek" } }
    refute flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Treatment.count' do
      delete client_treatment_path(@treatment.client, @treatment)
    end
    refute flash.empty?
    assert_redirected_to login_url
  end

end
