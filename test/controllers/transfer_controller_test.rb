require "test_helper"

class TransferControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get transfer_index_url
    assert_response :success
  end
end
