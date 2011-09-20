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

  context "with new category names" do
    it "creates them in categories table and then assigns them to message" do
      message.category_names = "faith, love, peace, kind"
      message.category_names.should eq("faith, kind, love, peace")
    end
  end

  context "with new verses" do
    it "creates them in verses table and then assigns them to message" do
      message.verse_refs = "John 3:16; 1 Corinthians 10:13"
      message.verse_refs.should eq("John 3:16; 1 Corinthians 10:13")
    end
  end
end
