require "test_helper"

class DepositControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get deposit_index_url
    assert_response :success
  end
end
