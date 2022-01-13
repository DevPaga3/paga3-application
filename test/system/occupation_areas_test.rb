require "application_system_test_case"

class OccupationAreasTest < ApplicationSystemTestCase
  setup do
    @occupation_area = occupation_areas(:one)
  end

  test "visiting the index" do
    visit occupation_areas_url
    assert_selector "h1", text: "Occupation Areas"
  end

  test "creating a Occupation area" do
    visit occupation_areas_url
    click_on "New Occupation Area"

    fill_in "Description", with: @occupation_area.description
    fill_in "Occupation", with: @occupation_area.occupation
    click_on "Create Occupation area"

    assert_text "Occupation area was successfully created"
    click_on "Back"
  end

  test "updating a Occupation area" do
    visit occupation_areas_url
    click_on "Edit", match: :first

    fill_in "Description", with: @occupation_area.description
    fill_in "Occupation", with: @occupation_area.occupation
    click_on "Update Occupation area"

    assert_text "Occupation area was successfully updated"
    click_on "Back"
  end

  test "destroying a Occupation area" do
    visit occupation_areas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Occupation area was successfully destroyed"
  end
end
