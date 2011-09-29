require 'spec_helper'

describe Category do
  let (:category) { Factory(:category) }

  it "should not be valid with blank name" do
    category.name = ""
    category.should_not be_valid
  end

  it "should not be valid with blank user" do
    category.user = nil 
    category.should_not be_valid
  end

  it "should not have duplicate name by the same user" do
    dup_category = Category.new(:name => "love", :user => category.user)
    dup_category.should_not be_valid
  end
end
