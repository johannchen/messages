require 'spec_helper'

describe "UserMessages" do
  before :each do
    login_with_oauth 
    @user = User.last
  end

  describe "Single Message Flows" do
    it "creates, displays and lists message by user" do
      # list
      visit messages_path 
      # page.should have_content "no messages found"
      # view links
      page.should have_link "New Message"
      page.should have_link "Calendar"
      page.should have_link "List"
      page.should have_link "Summary"
      click_link "New Message"
      current_path.should eq(new_message_path)
      # new
      fill_in "Title", :with => "my message"
      fill_in "message_speaker_name", :with => "Eric"
      fill_in "Mdate", :with => "2011-01-03"
      fill_in "Summary", :with => "What a message!"
      fill_in "Listened on", :with => "2011-09-03"
      fill_in "message_verse_refs", :with => "John 3:16; Matthew 3:2"
      fill_in "message_category_names", :with => "peace, kindness"
      click_button "Create"
      # save_and_open_page
      page.should have_content("Message was successfully created")
      current_path.should eq(message_path(Message.last))
      # display
      page.should have_content("my message")
      page.should have_content("Eric")
      page.should have_content("2011-01-03")
      page.should have_content("2011-09-03")
      page.should have_content("What a message!")
      page.should have_content("John 3:16")
      page.should have_content("God so loved the world")
      page.should have_content("peace, kindness")
      page.should have_link("Edit")
      page.should have_link("Messages")
      click_link "Edit"
      current_path.should eq(edit_message_path(Message.last))
      # edit
      page.should have_field("Title", :with => "my message")
      page.should have_field("message_speaker_name", :with => "Eric")
      page.should have_field("Listened on", :with => "2011-09-03")
      page.should have_field("message_verse_refs", :with => "John 3:16; Matthew 3:2")
      page.should have_field("message_category_names", :with => "peace, kindness")
      fill_in "Title", :with => "edit message"
      fill_in "message_speaker_name", :with => "Mondy"
      fill_in "Mdate", :with => "2011-02-03"
      fill_in "Summary", :with => "good message!"
      fill_in "Listened on", :with => "2011-10-03"
      fill_in "message_verse_refs", :with => "John 1:4; Matthew 6:2"
      fill_in "message_category_names", :with => "joy, leadership"
      click_button "Update"
      page.should have_content("Message was successfully updated")
      current_path.should eq(message_path(Message.last))
      # display edited message
      page.should have_content("edit message")
      page.should have_content("Mondy")
      page.should have_content("2011-02-03")
      page.should have_content("2011-10-03")
      page.should have_content("good message!")
      page.should have_content("John 1:4")
      page.should have_content("joy, leadership")
      page.should have_link("Edit")
      page.should have_link("Messages")
      # list message
      click_link "Messages"
      current_path.should eq(messages_path)
      page.should have_content("edit message")
      page.should have_content("By Mondy on Feb 03, 2011")
      page.should have_content("joy, leadership")
      page.should have_content("good message!")
    end
  end
  
  describe "Messages Summary View" do
    it "paginates every 10 messages" do
      22.times {|n| Factory(:message, :title => "m#{n}", :user => @user)}
      visit messages_path
      click_link "Summary"
      page.should have_no_link("Prev")
      page.should have_link("Next")
      click_link "Next"
      page.should have_link("Prev")
      page.should have_link("Next")
      click_link "Next"
      page.should have_no_link("Next")
      page.should have_link("Prev")
    end
  end

  describe "Messages List View" do
    it "paginates every 30 messages" do
      visit messages_path
      click_link "List"
    end
  end

  describe "Messages Calendar View" do
    it "displays messages in a calendar by listened date" do
      #Factory(:message)
      m1 = Factory(:message, :title => "one", :listened_on => "2011-10-08", :user => @user)
      m2 = Factory(:message, :title => "two", :listened_on => "2011-10-10", :user => @user)
      visit messages_path
      click_link "Calendar"
      page.should have_content("one")
      page.should have_content("two")
    end
  end

  describe "Messages Sidebar" do
    it "search title or summary", :focus => true do
      m1 = Factory(:message, :title => "one", :summary => "no good", :user => @user)
      m2 = Factory(:message, :title => "two", :summary => "one good message", :user => @user)
      visit messages_path
      fill_in "search", :with => "one"
      click_button "Search Messages"
      page.should have_content("one")
      page.should have_content("two")
    end
  end

  describe "Messages Sidebar" do
    it "filter messages by category and speaker" do
      # todo: factories mtm
      c1 = Factory(:category, :name => "Kindness", :user => @user)
      c2 = Factory(:category, :name => "Faithfullness", :user => @user)
      s1 = Factory(:speaker, :name => "Bob", :user => @user)
      s2 = Factory(:speaker, :name => "Steve", :user => @user)
      m1 = Factory(:message, :title => "one", :speaker => s1, :user => @user)
      m2 = Factory(:message, :title => "two", :speaker => s2, :user => @user)
      m1.categories << c1
      m2.categories << [c1, c2]

      visit messages_path
      page.should have_link("Kindness")
      page.should have_link("Faithfullness")
      page.should have_link("Bob")
      page.should have_link("Steve")
      click_link "Faithfullness"
      page.should have_no_link("Faithfullness")
      # page.should have_link("x")
      page.should have_no_content("one")
      page.should have_content("two")
      # filter with and
      #click_link "Bob"
      #page.should have_no_link("Bob")
      #page.should have_no_content("one")
      #page.should have_no_content("two")
    end
  end
end
