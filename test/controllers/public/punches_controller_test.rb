require "test_helper"

class Public::PunchesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_punches_new_url
    assert_response :success
  end

  test "should get index" do
    get public_punches_index_url
    assert_response :success
  end

  test "should get show" do
    get public_punches_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_punches_edit_url
    assert_response :success
  end
end
