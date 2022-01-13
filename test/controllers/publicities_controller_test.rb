require 'test_helper'

class PublicitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @publicity = publicities(:one)
  end

  test "should get index" do
    get publicities_url
    assert_response :success
  end

  test "should get new" do
    get new_publicity_url
    assert_response :success
  end

  test "should create publicity" do
    assert_difference('Publicity.count') do
      post publicities_url, params: { publicity: { description: @publicity.description, end_date: @publicity.end_date, start_date: @publicity.start_date, status: @publicity.status } }
    end

    assert_redirected_to publicity_url(Publicity.last)
  end

  test "should show publicity" do
    get publicity_url(@publicity)
    assert_response :success
  end

  test "should get edit" do
    get edit_publicity_url(@publicity)
    assert_response :success
  end

  test "should update publicity" do
    patch publicity_url(@publicity), params: { publicity: { description: @publicity.description, end_date: @publicity.end_date, start_date: @publicity.start_date, status: @publicity.status } }
    assert_redirected_to publicity_url(@publicity)
  end

  test "should destroy publicity" do
    assert_difference('Publicity.count', -1) do
      delete publicity_url(@publicity)
    end

    assert_redirected_to publicities_url
  end
end
