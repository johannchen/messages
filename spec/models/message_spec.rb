require 'spec_helper'

describe Message do
  let(:message) { Factory(:message) }
  context "with 2 or more categories" do
    it "displays them in alphbetical order" do
      c1 = Factory.build(:category, :name => "love")
      c2 = Factory.build(:category, :name => "faith")
      message.categories << [c1, c2]
      message.category_names.should eq("faith, love")
    end
  end
  context "with 2 or more verses" do
    it "displays them" do
      message.verse_refs.should eq("John 3:16; Matthew 1,2")
    end
  end
end
