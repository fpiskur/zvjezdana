require "test_helper"

class TreatmentTest < ActiveSupport::TestCase
  
  def setup
    @client = clients(:one)
    @treatment = @client.treatments.build(date: "2022-05-05",
                                          description: "blablabla")
  end

  test "should be valid" do
    assert @treatment.valid?
  end

  test "client id should be present" do
    @treatment.client_id = nil
    refute @treatment.valid?
  end

  test "date should be present" do
    @treatment.date = "     "
    refute @treatment.valid?
  end

  test "description should be present" do
    @treatment.description = "     "
    refute @treatment.valid?
  end

end
