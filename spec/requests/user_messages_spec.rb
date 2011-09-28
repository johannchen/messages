require 'spec_helper'

describe "UserMessages" do
  before :each do
    login_with_oauth 
  end

  describe "Single Message Flows" do
    it "creates, displays and lists message by user" do
      # list
      visit messages_path 
      page.should have_content "no messages found"
      page.should have_link "New Message"
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
      page.should have_link("Browse")
      click_link "Edit"
      current_path.should eq(edit_message_path(Message.last))
      # edit
      page.should have_field("Title", :with => "my message")
      page.should have_field("message_speaker_name", :with => "Eric")
      page.should have_field("Listened on", :with => "2011-09-03")
      page.should have_field("message_verse_refs", :with => "John 3:16; Matthew 3:2")
      page.should have_field("message_category_names", :with => "peace, kindness")
      fill_in("Title", :with => "edit message")
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
      page.should have_link("Browse")
      # list message
      click_link "Browse"
      current_path.should eq(messages_path)
      page.should have_content("edit message")
      page.should have_content("By Mondy on Feb 03, 2011")
      page.should have_content("joy, leadership")
      page.should have_content("good message!")
    end
  end
end
