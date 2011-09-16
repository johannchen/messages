require 'spec_helper'

describe Category do
  it "should not be valid with blank name" do
    category = Category.new(:name => "")
    category.should_not be_valid
  end

  it "should not have duplicate name" do
    Factory(:category, :name => "joy")
    category = Category.new(:name => "joy")
    category.should_not be_valid
  end
end
