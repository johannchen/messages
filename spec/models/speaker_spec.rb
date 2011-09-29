require 'spec_helper'

describe Speaker do
  let (:speaker) { Factory(:speaker) }

  it "should not be valid with blank name" do
    speaker.name = ""
    speaker.should_not be_valid
  end

  it "should not be valid with blank user" do
    speaker.user = nil 
    speaker.should_not be_valid
  end

  it "should not have duplicate name by the same user" do
    dup_speaker = Speaker.new(:name => "Tim Keller", :user => speaker.user)
    dup_speaker.should_not be_valid
  end
end
