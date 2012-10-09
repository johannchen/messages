class Message < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :verses
  belongs_to :speaker
  belongs_to :user

  #accepts_nested_attributes_for :verses, reject_if: lambda { |v| v[:ref].blank? }

  validates_presence_of :title, :user

  scope :order_by_listened_date, order("listened_on DESC")
  scope :book, lambda { |book| joins(:verses).where("verses.ref like ?", "%#{book}%")}

  attr_accessible :title, :listened_on, :summary, :url, :speaker_name, :category_names, :verse_refs

  attr_accessor :speaker_name, :category_names, :verse_refs  
  before_save :assign_speaker
  after_save :assign_categories 
  after_save :assign_verses

  require 'csv'

  def self.search(search)
    where(['lower(title) like ? or lower(summary) like ?', "%#{search.downcase}%", "%#{search.downcase}%"]) if search
  end 

  def self.download_csv
    messages = self.order("updated_at DESC")
    csv_data = CSV.generate do |csv|
      csv << ["Title", "Date", "Speaker", "Verses", "Categories", "Listened on", "Summary", "Note"]
      messages.map do |msg|
        csv << [
          msg.title,
          msg.mdate,
          msg.speaker_name,
          msg.verse_refs,
          msg.category_names,
          msg.listened_on,
          msg.summary,
          msg.note
        ]
      end
    end

    csv_data
  end

  def speaker_name
    @speaker_name || speaker.name if speaker
  end

  def category_names
    @category_names || categories.map(&:name)
  end

  def verse_refs
    @verse_refs || verses.map(&:ref)
  end

  private

  def assign_speaker
    if @speaker_name
      self.speaker = Speaker.find_or_create_by_name_and_user_id(@speaker_name, self.user_id) 
    end
  end

  def assign_categories
    if @category_names
      self.categories = @category_names.map do |name|
        Category.find_or_create_by_name_and_user_id(name, self.user_id)
      end
    end
  end

  def assign_verses
    if @verse_refs
      self.verses = @verse_refs.map do |ref|
        Verse.find_or_create_by_ref_and_user_id(ref, self.user_id)
      end
    end
  end
end
