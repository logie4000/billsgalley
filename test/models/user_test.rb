require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "user authenticate returns a user object" do
    u = users(:login_user)

    user = User.authenticate u.username, 'passw0rd'
    assert user

    user = User.authenticate u.username, 'bad_pass'
    assert_nil user

    user = User.authenticate 'NewUser', 'passw0rd'
    assert_nil user
  end

  test "validates email format for username" do
    user = User.new(:username => "hrollins@sst.org")
    assert user

    user = User.new(:username => "")
    assert_raises (StandardError) { user.save! }

    user = User.new(:username => "@sst.org")
    assert_raises (StandardError) { user.save! }
    
    user = User.new(:username => "hrollins")
    assert_raises (StandardError) { user.save! }
  end
end
