require "test_helper"

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: 'Example User', email: 'user@example.com',
                     password: 'hogehuga', password_confirmation: 'hogehuga')
  end

  test 'ユーザーが有効であること' do
    assert @user.valid?
  end

  test 'ユーザー名が存在すること' do
    @user.name = ' '
    assert_not @user.valid?
  end

  test 'メールアドレスが存在すること' do
    @user.email = ' '
    assert_not @user.valid?
  end

  test 'ユーザー名が60文字以下であること' do
    @user.name = 'a' * 61
    assert_not @user.valid?
  end

  test 'メールアドレスが文字以下であること' do
    @user.name = 'a' * 244 + '@example.com'
    assert_not @user.valid?
  end

  test 'メールアドレスのフォーマットが正しいこと' do
    valid_addresses = %w[hoge@gmail.com FUGA@foo.JP US_er@FOO.BAR.ORG a+b@gmail.COM]
    valid_addresses.each do |valid_addresses|
      @user.email = valid_addresses
      assert @user.valid?, "#{valid_addresses} should be valid"
    end
  end

  test 'メールアドレスが一意であること' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.downcase
    @user.save
    assert_not duplicate_user.valid?
  end
end
