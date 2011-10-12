require 'spec_helper'

describe "Verses" do
  before :each do
    login_with_oauth
    @user = User.last
  end

  describe "Favor Verses" do
    it "tags favor verse through message" do 
      m = Factory(:message, :user => @user)
      v = Factory(:verse, :user => @user)
      m.verses << v

      visit message_path(m)
      page.should have_link("like")
      #click_link ("like")
      #page.should have_link("dislike")
      #visit verses_path
      #page.should have_content("John 3:16")
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

    it "filters favor verses by book", :focus => true do
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
    end

    it "displays favor verses count by book and by category" do
    end

    it "removes verse from favor list" do
    end

  end

  describe "All Verses" do
    it "displays all verses" do
    end
    it "destroys verse" do
    end
  end

  # this should be in model spec
  #describe "DESTROY verse" do
  #  it "deletes verse and the associations of messages" do
  #  end
  #end
end
