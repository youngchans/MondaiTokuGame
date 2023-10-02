require "test_helper"

class LoginsControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get logins_login_url
    assert_response :success
  end
end
