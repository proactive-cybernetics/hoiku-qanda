require 'test_helper'

class AnswersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_answer_url(1)
    assert_response :success
  end

end
