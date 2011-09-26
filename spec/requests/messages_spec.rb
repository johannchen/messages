require 'spec_helper'

describe "Messages" do
  describe "list all messages" do
    before :each do
      10.times do 
        Factory(:message)
      end
      @m1 = Factory(:message, :title => "my message", :mdate => "2011-08-01")
      @m2 = Factory(:message, :title => "your message", :mdate => "2011-08-02")
      visit messages_path
    end

    # it "displays messages with the latest on top" do
    #   page.first("#messages li").should have_content(@m2.mdate)
    # end

    it "paginates with every 10 messages" do
      paginate_with_every_10_messages
    end
   
#   describe "search messages" do
#     it "displays all messages with empty search" do 
#       fill_in "Search", :with => ""
#       click_button "Search"
#       paginate_with_every_10_messages
#     end
#     it "displays all matched messages with title search" do
#       fill_in "Search", :with => "my"
#       click_button "Search"
#       page.all("#messages li").count.should eq(2)
#       page.should have_content("my message")
#       page.should have_no_link("Next")
#     end
#     it "displays no messages found when no record returns" do
#       fill_in "Search", :with => "whatever"
#       click_button "Search"
#      #  page.all("#messages li").count.should eq(0)
#       page.should have_content("no messages found") 
#       page.should have_no_link("Next")
#     end
#   end 
  end

  describe "show a specific message" do
    it "shows a message" do
      message = Factory(:message)
      visit message_path(message)
      page.should have_content("what a message!")
      # regex in content?
      # page.should have_content("love")
      page.should have_content("John 3:16")
      page.should have_content("God so loved the world")
    end 
  end 
 
  describe "create a new message" do
    before :each do 
      visit new_message_path
    end

    #it "autocompletes category", :js => true do
    #  fill_in "Category", :with => "su"
    #  page.should have_content("suffering")
    #end

    it "creates message", :js => true do
      click_button "Create"
      page.should have_content("This field is required")
      fill_in "Title", :with => "sunday message"
      fill_in "message_speaker_name", :with => "bob"
      fill_in "Mdate", :with => "2011-09-01"
      fill_in "message_verse_refs", :with => "John 1:4; Matthew 3:2"
      fill_in "message_category_names", :with => "peace, kindness"
      click_button "Create"
      page.should have_content("Message was successfully created")
      current_path.should eq(message_path(Message.last))
      page.should have_content("John 1:4")
      page.should have_content("Matthew 3:2")
      page.should have_content("kindness, peace")
    end
  end
  
  describe "update a specific message" do
    it "updates message", :js => true  do
      message = Factory(:message)
      visit edit_message_path(message)
      page.should have_field("Title", :with => "message")
      fill_in "Title", :with => "my message"
      click_button "Update"
      page.should have_content("This field is required")
      fill_in "Title", :with => "my message"
      click_button "Update"
      page.should have_content("Message was successfully updated")
      page.should have_content("my message")
      current_path.should eq(message_path(message))
    end
  end

#  describe "DELETE /messages" do 
#    it "destroys message", :js => true do
#      message = Factory(:message)
#      visit messages_path
#      page.should have_content("foo lee")
#      page.should have_link("Delete")
#      click_link "Delete"
#      page.should have_content("Are you sure?")
#      click_button "Ok"
#      page.should have_no_content("foo lee")
#    end
#  end

  private
  def paginate_with_every_10_messages
    # page.all("#messages li").count.should eq(10)
    page.should have_link("Next")
    click_link "Next"
    # page.all("#messages li").count.should eq(2)
    page.should have_link("Prev")
    click_link "Prev"
    # page.all("#messages li").count.should eq(10)
  end 
end
