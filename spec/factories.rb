FactoryGirl.define do
#  sequence :name do |n|
#    "love#{n}"
#  end

  factory :user do
   provider "twitter"
   uid "12345"
   email "jchen@example.com"
   first_name "j"
   last_name "chen"
   name "jchen"
  end

  factory :speaker do
    name "Tim Keller"
    church "Redeemer"
    user
  end

  factory :category do
    name "love"
    user
  end

  factory :verse do
    ref "John 3:16"
    user
  end

  factory :message do
    mdate "2011-01-01"
    title "message"
    summary "what a message!"
    url "http://www.gracedimension.com"
    speaker
    user
    #categories {[Factory(:category), Factory(:category, :name => "joy")]}
    #verses {[Factory(:verse), Factory(:verse, :ref => 'Romans 8:28')]}
  end

# factory :message_with_categories, :parent => :message do |message|
#   message.after_create do |m| 
#     factory(:category, :message => m) 
#     factory(:category, :name => "faith", :message => m) 
#   end
# end

end
