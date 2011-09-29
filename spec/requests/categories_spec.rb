require 'spec_helper'

describe "Categories" do
  before :each do
    login_with_oauth
  end

  describe "Single Category Flow" do
    it "creates, updates and lists category" do
      # create
      visit categories_path
      fill_in "category_name", :with => "love"
      click_button "Create"
      page.should have_content("Successfully added category.")
      # list on the same page
      page.should have_content("love")
      click_link "edit"
      # edit
      page.should have_field("category_name", :with => "love")
      fill_in "category_name", :with => "hate"
      click_button "Update"
      page.should have_content("Successfully updated category.")
      current_path.should eq(categories_path) 
      page.should have_content("hate")
    end
  end
end
