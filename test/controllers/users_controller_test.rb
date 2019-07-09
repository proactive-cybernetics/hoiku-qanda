require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should get home" do
    skip 'ホームの表示確認の方法を、後で考える'
    get home_url
    assert_response :success
  end

end
