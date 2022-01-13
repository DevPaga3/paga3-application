require 'test_helper'

class AdminsControllerTest < ActionDispatch::IntegrationTest
  test "should get details" do
    get admins_details_url
    assert_response :success
  end

end
