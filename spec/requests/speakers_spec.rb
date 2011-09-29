require 'spec_helper'

describe "Speakers" do
  before :each do
    login_with_oauth
  end

  describe "Single Speaker Flow" do
    it "creates, updates and lists speaker" do
      # create
      visit speakers_path 
      fill_in "Name", :with => "Eric Li"
      fill_in "Church", :with => "DCCC"
      click_button "Create"
      page.should have_content("Successfully added speaker.")
      # list on the same page
      page.should have_content("Eric Li")
      page.should have_content("DCCC")
      click_link "edit"
      current_path.should eq(edit_speaker_path(Speaker.last)) 
      # edit
      page.should have_field("Name", :with => "Eric Li")
      page.should have_field("Church", :with => "DCCC")
      fill_in "Name", :with => "Phillip G"
      click_button "Update"
      page.should have_content("Successfully updated speaker.")
      current_path.should eq(speakers_path) 
      page.should have_content("Phillip G")
      page.should have_field("Name", :with => "")
    end
  end
end
