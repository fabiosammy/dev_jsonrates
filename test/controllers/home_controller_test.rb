require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get home index" do
    get root_url
    assert_response :success
  end
end
