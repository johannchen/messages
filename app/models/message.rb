class Message < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :verses

  attr_reader :category_tokens

  validates_presence_of :title, :speaker, :mdate

  def category_tokens=(ids)
    self.category_ids = ids.split(",")
  end

  def self.search(search)
    where(['title like ? or speaker like ?', "%#{search}%", "%#{search}%"]).order("mdate desc") if search
  end 

  def category_names
    self.categories.order(:name).map(&:name).join(', ') if self.categories
  end

  def verse_refs
    self.verses.map(&:ref).join('; ') if self.verses
  end

end
