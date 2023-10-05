require "test_helper"

class StartsControllerTest < ActionDispatch::IntegrationTest
  test "should get start_p" do
    get starts_start_p_url
    assert_response :success
  end
end
