require 'test_helper'

class BusinessControllerTest < ActionController::TestCase
  test "should get pasos" do
    get :pasos
    assert_response :success
  end

end
