require "test_helper"

class MKControllerTest < ActionDispatch::IntegrationTest
  test "should get m_k_p" do
    get m_k_m_k_p_url
    assert_response :success
  end
end
