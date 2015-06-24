require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test "should get welcome" do
    get :welcome
    assert_response :success
  end

  test "should get thank_you" do
    get :thank_you
    assert_response :success
  end

end
