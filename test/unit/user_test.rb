require 'test_helper'
require 'shoulda'
require 'shoulda/active_record/macros'

class UserTest < Test::Unit::TestCase
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
end
