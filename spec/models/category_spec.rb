require 'spec_helper'

describe Category do
  it "should not be valid with blank name" do
    category = Category.new(:name => "")
    category.should_not be_valid
  end
end
