require 'test_helper'

class UserMessagesTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "capybara" do
    visit messages_path
    page.has_content?('Message')
  end
end
