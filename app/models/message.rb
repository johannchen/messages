class Message < ActiveRecord::Base
  validates_presence_of :title, :speaker, :mdate
  
  def self.search(search)
    where(['title like ? or speaker like ?', "%#{search}%", "%#{search}%"]).order("mdate desc") if search
  end 
end
