class User < ActiveRecord::Base
  has_many :messages
  has_many :categories
  has_many :speakers
  has_many :verses
end
