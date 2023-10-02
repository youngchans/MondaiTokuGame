require "test_helper"

class MainsControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get mains_main_url
    assert_response :success
  end
end
