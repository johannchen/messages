FactoryGirl.define do
  factory :category do
    name "love"
  end

  factory :message do
    mdate "2011-01-01"
    title "message"
    speaker "foo lee"
#    verses "John 3:16, Matthew 6:19-21"
    summary "what a message!"
    url "http://www.gracedimension.com"
    categories {[Factory(:category), Factory(:category, :name => 'faith')]}
  end

# factory :message_with_categories, :parent => :message do |message|
#   message.after_create do |m| 
#     factory(:category, :message => m) 
#     factory(:category, :name => "faith", :message => m) 
#   end
# end

end
