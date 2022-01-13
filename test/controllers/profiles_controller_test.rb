require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get details" do
    get profiles_details_url
    assert_response :success
  end

end
