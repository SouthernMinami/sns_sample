require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "/signupをGETすること" do
    get signup_url
    assert_response :success
  end
end
