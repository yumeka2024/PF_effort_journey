require "test_helper"

class Public::LabelsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_labels_index_url
    assert_response :success
  end
end
