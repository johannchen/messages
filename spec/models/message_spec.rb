require 'spec_helper'

describe Message do
  context "with 2 or more categories" do
    let(:message) { Factory(:message) }

    it "displays them in alphbetical order" do
      message.category_names.should eq("faith, love")
    end
  end
end
