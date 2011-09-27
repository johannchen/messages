class Category < ActiveRecord::Base
  has_and_belongs_to_many :messages
  belongs_to :user

  validates_presence_of :name, :user
end
