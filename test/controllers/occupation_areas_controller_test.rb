require 'test_helper'

class OccupationAreasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @occupation_area = occupation_areas(:one)
  end

  test "should get index" do
    get occupation_areas_url
    assert_response :success
  end

  test "should get new" do
    get new_occupation_area_url
    assert_response :success
  end

  test "should create occupation_area" do
    assert_difference('OccupationArea.count') do
      post occupation_areas_url, params: { occupation_area: { description: @occupation_area.description, occupation: @occupation_area.occupation } }
    end

    assert_redirected_to occupation_area_url(OccupationArea.last)
  end

  test "should show occupation_area" do
    get occupation_area_url(@occupation_area)
    assert_response :success
  end

  test "should get edit" do
    get edit_occupation_area_url(@occupation_area)
    assert_response :success
  end

  test "should update occupation_area" do
    patch occupation_area_url(@occupation_area), params: { occupation_area: { description: @occupation_area.description, occupation: @occupation_area.occupation } }
    assert_redirected_to occupation_area_url(@occupation_area)
  end

  test "should destroy occupation_area" do
    assert_difference('OccupationArea.count', -1) do
      delete occupation_area_url(@occupation_area)
    end

    assert_redirected_to occupation_areas_url
  end
end
