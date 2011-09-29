require 'spec_helper'

describe "Speakers" do
  before :each do
    login_with_oauth
  end

  describe "Single Speaker Flow" do
    it "creates, updates and lists speaker" do
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
  end
end
