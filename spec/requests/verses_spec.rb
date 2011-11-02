require 'spec_helper'

describe "Verses" do
  before :each do
    login_with_oauth
    @user = User.last
  end

  describe "Favorite Verses" do
    it "tags favorite verse through message", :focus => true do 
      m = Factory(:message, :user => @user)
      v = Factory(:verse, :user => @user)
      m.verses << v

      visit message_path(m)
      page.should have_link("like")
      click_link ("like")
      page.should have_no_link("like")
      visit verses_path
      page.should have_content("John 3:16")
    end


    it "paginates every 10 favorite verses" do
    end

    it "filters favorite verses by book" do
      v1 = Factory(:verse, :ref => "Genesis 1:1", :favorite => true, :user => @user)
      v2 = Factory(:verse, :favorite => true, :user => @user)
      visit verses_path
      page.should have_link("Genesis")
      page.should have_link("Revelation")
      page.should have_content("Genesis 1:1")
      page.should have_content("John 3:16")
      click_link "Genesis"
      page.should have_content("Genesis 1:1")
      page.should have_no_content("John 3:16")
      page.should have_no_link("Genesis")
    end

    it "filters favorite verses by category" do
      v1 = Factory(:verse, :ref => "Genesis 1:1", :favorite => true, :user => @user)
      v2 = Factory(:verse, :favorite => true, :user => @user)
      c1 = Factory(:category, :name => "Kindness", :user => @user)
      c2 = Factory(:category, :name => "Faithfullness", :user => @user)
      v1.categories << c1
      v2.categories << [c1, c2]

      visit verses_path
      page.should have_content("Genesis 1:1")
      page.should have_content("John 3:16")
      page.should have_link("Kindness")
      page.should have_link("Faithfullness")
      click_link "Faithfullness"
      page.should have_no_link("Faithfullness")
      page.should have_no_content("Genesis 1:1")
      page.should have_content("John 3:16")
    end

    it "removes verse from favorite list" do
      v = Factory(:verse, :favorite => true, :user => @user)
      visit verses_path
      page.should have_content("John 3:16")
      page.should have_link("dislike")
      click_link "dislike"
      page.should have_no_content("John 3:16")
      page.should have_no_link("remove")
    end

  end

  describe "All Verses" do

    it "displays all verses" do
      v1 = Factory(:verse, :ref => "Genesis 1:1", :user => @user)
      v2 = Factory(:verse, :favorite => true, :user => @user)

      visit verses_path
      page.should have_link("All")
      page.should have_no_link("Favor")
      page.should have_no_content("Genesis 1:1")
      page.should have_content("John 3:16")
      click_link ("All")
      page.should have_no_link("All")
      page.should have_content("Genesis 1:1")
      page.should have_content("John 3:16")
    end

    it "adds to favorite list" do
      v1 = Factory(:verse, :ref => "Genesis 1:1", :user => @user)
      visit verses_path
      click_link "All"
      page.should have_link("like")
      click_link "like"
      click_link "Favor"
      page.should have_no_link("Favor")
      page.should have_content("Genesis 1:1") 
    end
  end

  describe "Verse" do
    it "creates and updates verse" do
      visit verses_path
      click_link "Add Verse"
      # page.should have_checked_field("favor")
      fill_in "verse_ref", :with => "John 3:16"
      fill_in "verse_category_names", :with => "Love"
      check "verse_favorite"
      click_button "Create"
      current_path.should eq(verses_path)
      page.should have_content("John 3:16")
      page.should have_content("God so loved")
      page.should have_link("Love")
      click_link "edit"
      page.should have_field("verse_ref", :with => "John 3:16")
      fill_in "verse_ref", :with => "Genesis 1:1"
      click_button "Update"
      page.should have_content("Genesis 1:1")
    end

    it "deletes verse and its associations" do
      v = Factory(:verse, :favorite => true, :user => @user)
      c = Factory(:category, :user => @user)
      m = Factory(:message, :user => @user)
      v.categories << c
      v.messages << m

      visit verses_path
      page.should have_link("remove")
      click_link "remove"
      page.should have_no_content("John 3:16")
      page.should have_no_link("Love")
      click_link "All"
      page.should have_no_content("John 3:16")
      click_link "Messages"
      page.should have_no_content("John 3:16")
    end
  end
end
