require "application_system_test_case"

class PublicitiesTest < ApplicationSystemTestCase
  setup do
    @publicity = publicities(:one)
  end

  test "visiting the index" do
    visit publicities_url
    assert_selector "h1", text: "Publicities"
  end

  test "creating a Publicity" do
    visit publicities_url
    click_on "New Publicity"

    fill_in "Description", with: @publicity.description
    fill_in "End date", with: @publicity.end_date
    fill_in "Start date", with: @publicity.start_date
    check "Status" if @publicity.status
    click_on "Create Publicity"

    assert_text "Publicity was successfully created"
    click_on "Back"
  end

  test "updating a Publicity" do
    visit publicities_url
    click_on "Edit", match: :first

    fill_in "Description", with: @publicity.description
    fill_in "End date", with: @publicity.end_date
    fill_in "Start date", with: @publicity.start_date
    check "Status" if @publicity.status
    click_on "Update Publicity"

    assert_text "Publicity was successfully updated"
    click_on "Back"
  end

  test "destroying a Publicity" do
    visit publicities_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Publicity was successfully destroyed"
  end
end
