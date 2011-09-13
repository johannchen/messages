require 'test_helper'

class MessagesTest < ActionDispatch::IntegrationTest
  setup do
    10.times do
      Factory(:message)
    end
    @m1 = Factory(:message, :title => "my message", :speaker => "Jonathan", :mdate => "2011-10-10")
    @m2 = Factory(:message, :title => "your message", :speaker => "my Eric", :mdate => "2011-10-11")
  end

  test "should display all messages with the latest on top" do
    visit messages_path
    page.all("#messages li").first.has_content?(@m2.title)
  end

  test "should paginates every 10 messages" do
    assert_equal page.all("#messages li").count, 10
    page.has_link?("Next")
    click_link "Next"
    assert_equal page.all("#messages li").count, 2
    page.has_link?("Prev")
    click_link "Prev"
    assert_equal page.all("#messages li").count, 10
  end
end
