FactoryGirl.define do
  sequence :email do |n|
    "jchen#{n}@example.com"
  end

  factory :user do
   email 
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

  factory :message_with_category, :parent => :message do |message|
    message.after_create { |m| Factory(:category, :message => m) }
  end

# factory :message_with_categories, :parent => :message do |message|
#   message.after_create do |m| 
#     factory(:category, :message => m) 
#     factory(:category, :name => "faith", :message => m) 
#   end
# end

end
