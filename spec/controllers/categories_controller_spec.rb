require 'spec_helper'

describe CategoriesController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

# describe "GET 'create'" do
#   it "should be successful" do
#     get 'create'
#     response.should be_success
#   end
# end

# describe "GET 'update'" do
#   it "should be successful" do
#     get 'update'
#     response.should be_success
#   end
# end

end
