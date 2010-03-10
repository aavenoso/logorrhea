require 'test_helper'
require 'shoulda'
require 'shoulda/active_record/macros'
require 'mocha'

class UserTest <  ActiveSupport::TestCase

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
      user = User.new(first_name: 'John', last_name: 'Doe', username: 'jdoe')
      assert_equal "John Doe", user.name
    end
  end

  context "Mentioned In" do
    should "return an empty list if there are no messages" do
      user = User.new(first_name: 'John', last_name: 'Doe', username: 'jdoe')
      assert_equal(0, user.mentioned_in.size)
    end
    should "find some messages" do
      user = User.new(username: 'jdoe')
      Message.expects(:mentioning).with('jdoe').returns ['foo']
      messages = user.mentioned_in
      assert_equal(1, messages.size)
    end
  end
end
