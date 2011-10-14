require 'spec_helper'

describe "Speakers" do
  before :each do
    login_with_oauth
    @user = User.last
  end

  describe "Speaker" do
    it "creates, updates and shows peaker" do
      # create
      visit speakers_path 
      page.should have_content("no speaker found")
      fill_in "Name", :with => "Jonathan L"
      fill_in "Church", :with => "Gracepoint"
      fill_in "Link", :with => "http://joonglee.wordpress.org"
      click_button "Create"
      page.should have_content("Successfully added speaker.")
      # list on the same page
      page.should have_content("Jonathan L")
      page.should have_content("Gracepoint")
      click_link "edit"
      current_path.should eq(edit_speaker_path(Speaker.last)) 
      # edit
      page.should have_field("Name", :with => "Jonathan L")
      page.should have_field("Church", :with => "Gracepoint")
      fill_in "Name", :with => "Ed K"
      click_button "Update"
      page.should have_content("Successfully updated speaker.")
      current_path.should eq(speakers_path) 
      page.should have_content("Ed K")
    end

    it "displays number of messages" do
      s1 = Factory(:speaker, :user => @user)
      s2 = Factory(:speaker, :name => "Eric", :link => "", :user => @user)
      m = Factory(:message, :speaker => s1, :user => @user)

      visit speakers_path
      page.should have_link("blog")
      page.should have_link("1")
      page.should have_content("0")
      page.should have_no_link("0")
      click_link "1"
      current_url.should eq(messages_url(:speaker => s1.id))
    end
  end
end
