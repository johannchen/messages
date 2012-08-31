require 'spec_helper'

describe "login" do

  describe "guest" do
    it "displays welcome message" do
      visit root_url
      page.should have_link("Sign in with Google")
      # page.should have_no_link("Messages")
      page.should have_no_link("Verses")
      page.should have_no_field("search")
      page.should have_content("Sermon Messages helps you to keep track of your messages.")
    end

    it "cannot access to other pages" do
      visit messages_path
      # page.should have_content("Not authorized to index message. Please sign in first")
      current_path.should eq(root_path)
    end
  end

  describe "login with Google account", focus: true do
    it "displays username after login" do
      login_with_oauth
      page.should have_content("Welcome jchen!")
      page.should have_link("Sign Out")
      page.should have_link("Messages")
      page.should have_link("Verses")
      page.should have_field("search")
    end

    it "displays sign in link after sign out" do
      login_with_oauth
      click_link "Sign Out"
      page.should have_link("Sign in with Google")
    end
  end
end

