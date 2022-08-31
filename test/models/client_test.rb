require "test_helper"

class ClientTest < ActiveSupport::TestCase
  
  def setup
    @client = Client.new(first_name: "Pero", last_name: "Pero",
                         phone_num: "234-123", comment: "Random whatever")
  end

  test "should be valid" do
    assert @client.valid?
  end

  test "first and last name should both be present" do
    @client.first_name = "   "
    @client.last_name = "   "
    refute @client.valid?
  end

  test "should be valid with just the first name" do
    @client.last_name = ""
    assert @client.valid?
  end

  test "should be valid with just the last name" do
    @client.first_name = ""
    assert @client.valid?
  end

  test "associated treatments should be destroyed" do
    @client.save
    @client.treatments.create!(date: "2022-05-05", description: "Burek")
    assert_difference 'Treatment.count', -1 do
      @client.destroy
    end
  end

end
