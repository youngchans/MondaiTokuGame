require "test_helper"

class QuesControllerTest < ActionDispatch::IntegrationTest
  test "should get ques_p" do
    get ques_ques_p_url
    assert_response :success
  end
end
