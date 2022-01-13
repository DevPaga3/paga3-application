require 'test_helper'

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  test "should get details" do
    get companies_details_url
    assert_response :success
  end

end
