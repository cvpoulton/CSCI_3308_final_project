require 'test_helper'

class AccountControllerTest < ActionController::TestCase
  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get friends" do
    get :friends
    assert_response :success
  end

  test "should get preferences" do
    get :preferences
    assert_response :success
  end

end
