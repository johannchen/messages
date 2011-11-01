require 'spec_helper'

describe Message do
  let(:message) { Factory(:message) }

  it "should not be valid with blank title" do
    message.title = "" 
    message.should_not be_valid
  end

#  it "should not be valid with blank mdate" do
#    message.mdate = "" 
#    message.should_not be_valid
#  end

#  it "should not be valid with blank speaker" do
#    message.speaker = nil 
#    message.should_not be_valid
#  end

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

#  context "with many messages" do
#    m1 = Factory(:message, :listened_on => "")
#    m2 = Factory(:message, :listened_on => "2011-09-30")
#    m3 = Factory(:message, :listened_on => "2011-09-29")
#    it "sorts them by listened date with to listen on top" do
#      Message.all.count.should eq(3)
#      Message.order_by_listened_date.should eq([m1, m2, m3])
#    end
#  end
end
