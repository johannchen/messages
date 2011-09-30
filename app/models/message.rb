class Message < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :verses
  belongs_to :speaker
  belongs_to :user

  validates_presence_of :title, :mdate, :user

  scope :order_by_listened_date, order("listened_on DESC")
  attr_writer :speaker_name, :category_names, :verse_refs
  before_save :assign_speaker
  after_save :assign_categories, :assign_verses

  def self.search(search)
    where(['title like ? or speaker like ?', "%#{search}%", "%#{search}%"]).order("mdate desc") if search
  end 

  def speaker_name
    @speaker_name || speaker.name if speaker
  end

  def category_names
    @category_names || categories.map(&:name).join(', ')
  end

  def verse_refs
    @verse_refs || verses.map(&:ref).join('; ')
  end

  private

  def assign_speaker
    if @speaker_name
      self.speaker = Speaker.find_or_create_by_name_and_user_id(@speaker_name, self.user_id) 
    end
  end

  def assign_categories
    if @category_names
      self.categories = @category_names.split(/,\s+/).map do |name|
        Category.find_or_create_by_name_and_user_id(name, self.user_id)
      end
    end
  end

  def assign_verses
    if @verse_refs
      self.verses = @verse_refs.split(/;\s+/).map do |ref|
        Verse.find_or_create_by_ref_and_user_id(ref, self.user_id)
      end
    end
  end
end
