require 'spec_helper'

describe "Login" do

  describe "Guest" do
    it "displays welcome message" do
      visit root_url
      page.should have_link("Sign in with Twitter")
      page.should have_no_link("Messages")
      #page.should have_no_link("Verses")
      page.should have_no_link("Speakers")
      page.should have_no_link("Categories")
      page.should have_no_field("search")
      page.should have_content("This application helps you to keep track with the sermon messages you have listened.")
    end

    it "cannot access to other pages" do
      visit messages_path
      page.should have_content("Not authorized to index message. Please sign in first")
      # current_path.should eq(root_url)
    end
  end

  describe "Login with twitter" do
    it "displays username after login" do
      login_with_oauth
      page.should have_content("Welcome jchen!")
      page.should have_link("Sign Out")
      page.should have_link("Messages")
      #page.should have_link("Verses")
      page.should have_link("Speakers")
      page.should have_link("Categories")
      page.should have_field("search")
    end

    it "displays sign in link with twitter after sign out" do
      login_with_oauth
      click_link "Sign Out"
      page.should have_link("Sign in with Twitter")
    end
  end
end

