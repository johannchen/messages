FactoryGirl.define do
  factory :message do
    mdate "2011-01-01"
    title "message"
    speaker "foo lee"
#    verses "John 3:16, Matthew 6:19-21"
    summary "what a message!"
    url "http://www.gracedimension.com"
  end
end
