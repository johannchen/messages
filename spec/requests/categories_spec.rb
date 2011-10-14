require 'spec_helper'

describe "Categories" do
  before :each do
    login_with_oauth
    @user = User.last
  end

  describe "Category" do
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

    it "displays number of messages and verses", :focus => true do
      c1 = Factory(:category, :user => @user)
      c2 = Factory(:category, :name => "Hate", :user => @user)
      m = Factory(:message, :user => @user)
      v1 = Factory(:verse, :user => @user)
      v2 = Factory(:verse, :ref => "Genesis 1:1", :user => @user)
      
      c1.messages << m
      c1.verses << [v1, v2]

      visit categories_path
      page.should have_link("1")
      page.should have_link("2")
      page.should have_content("0")
      page.should have_no_link("0")
      click_link "1"
      current_url.should eq(messages_url(:cat => c1.id))
      click_link "Categories"
      click_link "2"
      current_url.should eq(verses_url(:cat => c1.id))
    end

    it "removes category" do
    end
  end
end
