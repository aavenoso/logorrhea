require 'test_helper'
require 'shoulda'
require 'shoulda/active_record/macros'
require 'factory_girl'

class UserTest < Test::Unit::TestCase
  Factory.define :user do | u |
    u.first_name 'John'
    u.last_name 'Doe'
    u.email 'jdoe@email.com'
    u.password 'password'
    u.username 'jdoe'
  end

  context "User Validation" do
    should_validate_presence_of :username, :first_name, :last_name, :email, :password
    should_not_allow_values_for :email, "blah", "foo@", "@hotmail.com", "foo@hotmail"
    should_allow_values_for :email, "foo@hotmail.com"
    should_ensure_length_at_least :password, 7
  end

  context "User Relations" do
    should_belong_to :team
    should_have_many :messages
  end

  context "User Name" do
    should "combine the user's name" do
      assert_equal "John Doe", Factory(:user).name
    end
  end
end
