require 'spec_helper'

describe "Categories" do
  describe "GET /categories" do
    it "displays categories" do
      Factory(:category, :name => "love")
      visit categories_path
      page.should have_content("love")
      page.should have_link("edit")
    end
  end

  describe "POST /categories" do
    it "creates category" do
      visit categories_path
      fill_in "category_name", :with => "hate"
      click_button "Create"
      page.should have_content("Successfully added category.")
      # sleep(3)
      # page.should have_no_content("Successfully added category.")
      page.should have_content("hate")
    end
  end

  describe "PUT /categories" do
    it "updates category" do
      Factory(:category, :name => "love")
      visit categories_path
      click_link "edit"
      page.should have_field("category_name", :with => "love")
      fill_in "category_name", :with => "hate"
      click_button "Update"
      page.should have_content("Successfully updated category.")
      current_path.should eq(categories_path) 
    end
  end
end
