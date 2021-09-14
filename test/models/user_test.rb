require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'the first User created is first in the list' do
     first_user = User.new email: 'user1@gmail.com',
                           password: 'password'
     first_user.save!
     second_user = User.new email: 'user2@gmail.com',
                           password: 'password'
     second_user.save!
     assert_equal(first_user, User.all.first)
  end

  test 'updated_at is changed after updating email' do
    user = User.new email: 'user1@gmail.com',
                    password: 'password'
    user.save!
    first_updated_at = user.updated_at
    user.email = 'sylviane@gmail.com'
    user.save!
    refute_equal(user.updated_at, first_updated_at)
  end

  # test 'user has no email' do
  #   user = User.new password: 'password'
  #   refute user.valid?
  # end

  test 'user has wrongly formatted email' do
    user1 = User.new email: 'usergmail.com',
                     password: 'password'
    user2 = User.new email: 'user@gmailcom',
                     password: 'password'
    user3 = User.new email: 'user@gmail.com',
                     password: 'password'
    refute user1.valid?
    # refute user2.valid? Is valid instead… (see user.rb:6-8)
    assert user3.valid?
  end

  test 'user has no password' do
    user = User.new email: 'user@gmail.com'
    refute user.valid?
  end

  test 'user role is initialized as registered by default' do
    user = User.new email: 'user1@gmail.com',
                    password: 'password'
    assert_equal(user.role, 'registered')
  end

  test 'user email is lowercased before validation' do
    user = User.new email: 'nEw@EpFl.Ch', password: 'password'
    user.save!
    assert user.valid?
    assert_equal(user.email, 'new@epfl.ch')
  end

end
