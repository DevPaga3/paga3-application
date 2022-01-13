require 'test_helper'

class ConfigurationsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get configurations_show_url
    assert_response :success
  end

end
