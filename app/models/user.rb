class User < ActiveRecord::Base
  has_many :authentications
  has_many :messages
  has_many :categories
  has_many :speakers
  has_many :verses

  validates_presence_of :name, :email 
  validates_uniqueness_of :email

  def add_provider(auth)
    unless authentications.find_by_provider_and_uid(auth["provider"], auth["uid"])
      Authentication.create :user => self, :provider => auth["provider"], :uid => auth["uid"]
    end 
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.name = auth["user_info"]["name"]
      user.email = auth["user_info"]["email"]
    end
  end
end
