require 'test_helper'

class ViewingControllerTest < ActionController::TestCase
  test "should get newsfeed" do
    get :newsfeed
    assert_response :success
  end

  test "should get profile" do
    get :profile
    assert_response :success
  end

end
