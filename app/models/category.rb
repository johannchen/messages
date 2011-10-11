class Category < ActiveRecord::Base
  has_and_belongs_to_many :messages
  has_and_belongs_to_many :verses
  belongs_to :user

  validates_presence_of :name, :user
  validates_uniqueness_of :name, :scope => :user_id
end
