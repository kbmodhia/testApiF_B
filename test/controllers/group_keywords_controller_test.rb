require "test_helper"

class GroupKeywordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @group_keyword = group_keywords(:one)
  end

  test "should get index" do
    get group_keywords_url
    assert_response :success
  end

  test "should get new" do
    get new_group_keyword_url
    assert_response :success
  end

  test "should create group_keyword" do
    assert_difference('GroupKeyword.count') do
      post group_keywords_url, params: { group_keyword: { groupid: @group_keyword.groupid, keyword: @group_keyword.keyword, userid: @group_keyword.userid } }
    end

    assert_redirected_to group_keyword_url(GroupKeyword.last)
  end

  test "should show group_keyword" do
    get group_keyword_url(@group_keyword)
    assert_response :success
  end

  test "should get edit" do
    get edit_group_keyword_url(@group_keyword)
    assert_response :success
  end

  test "should update group_keyword" do
    patch group_keyword_url(@group_keyword), params: { group_keyword: { groupid: @group_keyword.groupid, keyword: @group_keyword.keyword, userid: @group_keyword.userid } }
    assert_redirected_to group_keyword_url(@group_keyword)
  end

  test "should destroy group_keyword" do
    assert_difference('GroupKeyword.count', -1) do
      delete group_keyword_url(@group_keyword)
    end

    assert_redirected_to group_keywords_url
  end
end
