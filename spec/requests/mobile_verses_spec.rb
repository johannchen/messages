require 'spec_helper'

describe "MobileVerses" do
  let(:user) { login_with_oauth }
  let(:verse) { Factory(:verse, :user => user) }

  describe "Home Verse", :js => true, :focus => true do
    it "displays last favorite verse at home screen" do
      visit root_url
      click_link "Mobile Site"
      page.should have_content(verse.ref)
    end
  end
end
