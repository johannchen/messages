require 'spec_helper'

describe Message do
  let(:message) { Factory(:message) }

  it "should not be valid with blank title" do
    message.title = "" 
    message.should_not be_valid
  end

  it "should not be valid with blank mdate" do
    message.mdate = "" 
    message.should_not be_valid
  end

  it "should not be valid with blank speaker" do
    message.speaker = nil 
    message.should_not be_valid
  end

  it "should not be valid with blank user" do
    message.user = nil
    message.should_not be_valid
  end

  context "with more than 2 category names" do
    it "assigns them to message" do
      message.category_names = "love, joy"
      message.category_names.should eq("love, joy")
    end
  end

  context "with new speaker name" do
    it "assigns it to message" do
      message.speaker_name = "Rick Warren"
      message.speaker_name.should eq("Rick Warren")
    end
  end

  context "with new verses" do
    it "assigns them to message" do
      message.verse_refs = "John 3:16; 1 Corinthians 10:13"
      message.verse_refs.should eq("John 3:16; 1 Corinthians 10:13")
    end
  end
end
