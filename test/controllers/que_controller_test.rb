require "test_helper"

class QueControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get que_index_url
    assert_response :success
  end

  test "should get new" do
    get que_new_url
    assert_response :success
  end

  test "should get create" do
    get que_create_url
    assert_response :success
  end

  test "should get edit" do
    get que_edit_url
    assert_response :success
  end

  test "should get update" do
    get que_update_url
    assert_response :success
  end

  test "should get destroy" do
    get que_destroy_url
    assert_response :success
  end
end
