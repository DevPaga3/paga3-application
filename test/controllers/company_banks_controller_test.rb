require 'test_helper'

class CompanyBanksControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get company_banks_new_url
    assert_response :success
  end

end
