require 'test_helper'

class AnswerRepliesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get answer_replies_new_url
    assert_response :success
  end

  test "should get create" do
    get answer_replies_create_url
    assert_response :success
  end

end
