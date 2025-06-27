require "test_helper"

class PropertiesControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get properties_search_url
    assert_response :success
  end

  test "should get developments" do
    get properties_developments_url
    assert_response :success
  end
end
