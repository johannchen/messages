require 'spec_helper'

describe Verse do
  let(:verse) { Factory(:verse) }
  describe "#esv_passage" do
    it "display the esv passage of the verse reference" do
      verse.ref.should eq("John 3:16")
      verse.esv_passage.should match "God so loved the world"
    end
  end
end
