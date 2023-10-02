require "test_helper"

class RankingControllerTest < ActionDispatch::IntegrationTest
  test "should get rank_p" do
    get ranking_rank_p_url
    assert_response :success
  end
end
