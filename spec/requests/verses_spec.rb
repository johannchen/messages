require 'spec_helper'

describe "Verses" do
  let(:user) { login_with_oauth }

  describe "Favorite Verses" do
    it "creates and updates verse", focus: true do
      visit verses_path
      click_button "New Verse"
      fill_in "verse_ref", with: "John 15:5"
      fill_in "verse_content", with: "I am the vine; you are the branches. Whoever abides in me and I in him, he it is that bears much fruit, for apart from me you can do nothing." 
      fill_in "verse_category_names", with: "Abide"
      click_button "Add Verse"
      current_path.should eq(verses_path)
      page.should have_content("John 15:5")
      page.should have_content("I am the vine")
      page.should have_link("Abide")
      click_link "edit"
      page.should have_field("verse_ref", :with => "John 15:5")
      fill_in "verse_ref", with: "John 12:25"
      fill_in "verse_content", with: "Whoever loves his life loses it, and whoever hates his life in this world will keep it for eternal life." 
      click_button "Update"
      page.should have_content("John 12:25")
      page.should have_content("loves his life loses it")
    end

    it "tags favorite verse through message" do 
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
      page.should have_no_content("Genesis 1:1")
      page.should have_content("John 3:16")
      click_link ("All")
      page.should have_content("Genesis 1:1")
      page.should have_content("John 3:16")
    end

    it "adds to favorite list" do
      v1 = Factory(:verse, :ref => "Genesis 1:1", :user => @user)
      visit verses_path
      click_link "All"
      page.should have_link("like")
      click_link "like"
      page.should have_content("Genesis 1:1") 
    end
  end

  describe "Verse" do
   
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
