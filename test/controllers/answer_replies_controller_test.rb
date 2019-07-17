require 'test_helper'

class AnswerRepliesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_reply_url(1)
    assert_response :success
  end

  test "should get create" do
    skip '返信作成の確認方法を、後で考える'
    get answer_replies_create_url
    assert_response :success
  end

end
