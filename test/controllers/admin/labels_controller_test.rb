require "test_helper"

class Admin::LabelsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_labels_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_labels_show_url
    assert_response :success
  end
end
