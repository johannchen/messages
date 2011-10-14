require 'spec_helper'

describe "Verses" do
  before :each do
    login_with_oauth
    @user = User.last
  end

  describe "Favor Verses" do
    it "tags favor verse through message", :focus => true do 
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

    it "creates favor verse" do
      visit verses_path
      fill_in "verse_ref", :with => "John 3:16"
      fill_in "verse_category_names", :with => "Love"
      click_button "Create"
      page.should have_content("John 3:16")
      page.should have_content("God so love")
    end

    it "paginates every 10 favor verses" do
    end

    it "filters favor verses by book" do
      v1 = Factory(:verse, :ref => "Genesis 1:1", :favor => true, :user => @user)
      v2 = Factory(:verse, :favor => true, :user => @user)
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

    it "filters favor verses by category" do
      v1 = Factory(:verse, :ref => "Genesis 1:1", :favor => true, :user => @user)
      v2 = Factory(:verse, :favor => true, :user => @user)
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

    it "removes verse from favor list" do
      v = Factory(:verse, :favor => true, :user => @user)
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
      v2 = Factory(:verse, :favor => true, :user => @user)

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

    it "adds to favor list" do
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


  describe "DESTROY Verse" do
    it "deletes verse and its associations" do
      v = Factory(:verse, :favor => true, :user => @user)
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
