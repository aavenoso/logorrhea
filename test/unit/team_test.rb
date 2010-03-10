require 'test_helper'
require 'factory_girl'
require 'shoulda'
require 'shoulda/active_record/macros'
require 'faker'

class TeamTest < ActiveSupport::TestCase
  Factory.define :team do |t|
    t.name "test team"
  end

  Factory.define :user do |t|
    t.username "user"
    t.first_name "joe"
    t.last_name "smith"
    t.email "joesmith@yahoo.com"
    t.password "asdfasdf"
  end

  Factory.define :message do |t|
    t.body "Foobar"
  end

  Factory.sequence :body do |n|
    "foobar#{n}"
  end

  Factory.sequence :created_at do |n|
    Time.gm(2010,1,1,0,0,0) + n
  end

  context "Most recent team messages with single user" do
    setup do
      @team = Factory(:team)
      @user = Factory(:user, :team => @team)
    end
    should "Return Single message as most recent" do
      @message = Factory(:message, :user => @user)
      assert_equal 1, @team.messages.most_recent(1).count
      assert_equal @message, @team.messages.most_recent(1)[0]
    end

    should "Return 5 messages by default" do
      msgs = generate_multiple_messages(6, @user)
      assert_equal 5, @team.messages.most_recent.count
      assert !@team.messages.most_recent.include?(msgs[0]), "First message should not be in recent messages"
      (1..5).each do |i|
        assert @team.messages.most_recent.include?(msgs[i])
      end
    end
    
    should "Return 2 messages when specifying 2 and there are more than 2" do
      generate_multiple_messages(3, @user)
      assert_equal 2, @team.messages.most_recent(2).count
    end
  end

  def generate_multiple_messages(count, user)
    msgs = []
    count.times do
      msgs << Factory(:message, :user => user,
                      :body => Factory.next(:body),
                      :created_at => Factory.next(:created_at))
    end
    msgs
  end

end

