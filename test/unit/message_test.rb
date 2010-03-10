require 'test_helper'
require 'shoulda'
require 'shoulda/active_record/macros'
require 'factory_girl'
require 'faker'

class MessageTest < ActiveSupport::TestCase
  include Faker
  
  Factory.define :message do |m|
    m.body Lorem.sentence
    m.user_id 1
    m.priority rand(4)
  end
  
  def message_with_replies
    parent = nil
    thread = []
    (1..5).each do |m|
      m = Factory(:message)
      m.parent_id = parent
      m.save
      parent ||= m.id
      thread << m
    end
    thread
  end
  
  context "Message Validation" do
    should_validate_presence_of :body, :user_id
  end

  context "Message Relations" do
    should_belong_to :user
    should_have_many :children
  end

  context "Message Body" do
    setup do
      @message = Message.new body: "http://example.com"
    end
    should "linkify hyperlinks" do
      assert_equal %q{<a href="http://example.com">http://example.com</a>}, @message.body_for_display
    end
  end
  
  context "Message Thread" do
    setup do
      @messages = message_with_replies
    end
    should "be children of the first message" do
      parent, children = @messages.first, @messages[1,@messages.size]
      assert children.all?(){|child| parent.children.include? child}
    end #should
  end #context
  
end
