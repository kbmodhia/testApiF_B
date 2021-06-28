require "application_system_test_case"

class GroupKeywordsTest < ApplicationSystemTestCase
  setup do
    @group_keyword = group_keywords(:one)
  end

  test "visiting the index" do
    visit group_keywords_url
    assert_selector "h1", text: "Group Keywords"
  end

  test "creating a Group keyword" do
    visit group_keywords_url
    click_on "New Group Keyword"

    fill_in "Groupid", with: @group_keyword.groupid
    fill_in "Keyword", with: @group_keyword.keyword
    fill_in "Userid", with: @group_keyword.userid
    click_on "Create Group keyword"

    assert_text "Group keyword was successfully created"
    click_on "Back"
  end

  test "updating a Group keyword" do
    visit group_keywords_url
    click_on "Edit", match: :first

    fill_in "Groupid", with: @group_keyword.groupid
    fill_in "Keyword", with: @group_keyword.keyword
    fill_in "Userid", with: @group_keyword.userid
    click_on "Update Group keyword"

    assert_text "Group keyword was successfully updated"
    click_on "Back"
  end

  test "destroying a Group keyword" do
    visit group_keywords_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Group keyword was successfully destroyed"
  end
end
