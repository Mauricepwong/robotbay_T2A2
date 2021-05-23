require "test_helper"

class RobotsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get robots_index_url
    assert_response :success
  end

  test "should get new" do
    get robots_new_url
    assert_response :success
  end

  test "should get create" do
    get robots_create_url
    assert_response :success
  end

  test "should get show" do
    get robots_show_url
    assert_response :success
  end

  test "should get edit" do
    get robots_edit_url
    assert_response :success
  end

  test "should get update" do
    get robots_update_url
    assert_response :success
  end

  test "should get destroy" do
    get robots_destroy_url
    assert_response :success
  end
end
