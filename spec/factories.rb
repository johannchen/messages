FactoryGirl.define do
  sequence :name do |n|
    "love#{n}"
  end

# factory :user do
#   email "bob@example.com"
#   first_name "bob"
#   last_name "chen"
# end

  factory :speaker do
    name "Tim Keller"
    church "Redeemer"
  end

  factory :category do
    name
  end

  factory :verse do
    ref "John 3:16"
  end

  factory :message do
    mdate "2011-01-01"
    title "message"
    summary "what a message!"
    url "http://www.gracedimension.com"
    speaker
    # categories {[Factory(:category), Factory(:category)]}
    verses {[Factory(:verse), Factory(:verse, :ref => 'Romans 8:28')]}
  end

# factory :message_with_categories, :parent => :message do |message|
#   message.after_create do |m| 
#     factory(:category, :message => m) 
#     factory(:category, :name => "faith", :message => m) 
#   end
# end

end
