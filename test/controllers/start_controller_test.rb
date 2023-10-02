require "test_helper"

class StartControllerTest < ActionDispatch::IntegrationTest
  test "should get start_p" do
    get start_start_p_url
    assert_response :success
  end
end
