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

# it "should not have duplicate name" do
#   Factory(:category, :name => "joy")
#   category = Category.new(:name => "joy")
#   category.should_not be_valid
# end
end
