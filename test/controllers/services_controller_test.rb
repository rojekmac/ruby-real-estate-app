require "test_helper"

class ServicesControllerTest < ActionDispatch::IntegrationTest
  test "should get valuation" do
    get services_valuation_url
    assert_response :success
  end
end
