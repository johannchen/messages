class Message < ActiveRecord::Base
  has_and_belongs_to_many :categories

  validates_presence_of :title, :speaker, :mdate
  
  def self.search(search)
    where(['title like ? or speaker like ?', "%#{search}%", "%#{search}%"]).order("mdate desc") if search
  end 
end
