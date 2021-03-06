require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest

  test '無効なユーザー情報送信時、登録ページがレンダリングされること' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:     "",
                                          email:    "user@invalid",
                                          password: "foo",
                                          password_confirmation: "bar" }}
    end
    assert_template 'users/new'
  end

  test '有効なユーザー情報送信時、ユーザー表示ページがレンダリングされること' do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:     "user",
                                         email:    "user@example.com",
                                         password: "foobar",
                                         password_confirmation: "foobar"}}
    end
    follow_redirect!
    assert_template 'users/show'
  end
end
