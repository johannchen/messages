class Message < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :verses
  belongs_to :speaker
  belongs_to :user

  validates_presence_of :title, :speaker, :mdate

  def self.search(search)
    where(['title like ? or speaker like ?', "%#{search}%", "%#{search}%"]).order("mdate desc") if search
  end 

  def speaker_name
    speaker.name if speaker
  end

  def speaker_name=(name)
    self.speaker = Speaker.find_or_create_by_name(name) if name.present? 
  end

  def category_names
    categories.order("name ASC").map(&:name).join(', ') if categories
  end

  def category_names=(names)
    self.categories.clear
    if names.present? 
      names.split(", ").each do |n|
        name = Category.find_or_create_by_name(n)
        self.categories << name    
      end
    end
  end

  def verse_refs
    self.verses.map(&:ref).join('; ') if self.verses
  end

  def verse_refs=(refs)
    self.verses.clear
    if refs.present?
      refs.split('; ').each do |r|
        ref = Verse.find_or_create_by_ref(r)
        self.verses << ref 
      end
    end
  end

end
