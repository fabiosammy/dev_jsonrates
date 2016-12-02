require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get home index" do
    get root_url
    assert_response :success
  end

  test "should update stocks and redirect to home" do
    ENV['ENDPOINT_API_KEY'] = nil
    get update_stocks_url
    assert_redirected_to root_path
  end
end
