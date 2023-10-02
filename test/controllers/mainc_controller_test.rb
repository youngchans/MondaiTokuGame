require "test_helper"

class MaincControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get mainc_main_url
    assert_response :success
  end
end
