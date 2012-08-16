class Verse < ActiveRecord::Base
  has_and_belongs_to_many :messages
  has_and_belongs_to_many :categories
  belongs_to :user

  validates_presence_of :ref, :user
  validates_uniqueness_of :ref, scope: :user_id 

  scope :favorites, where(:favorite => true)
  scope :book, lambda { |book| where("ref like ?", "%#{book}%") }

  attr_accessor :category_names
  after_save :assign_categories

  require 'open-uri'
  
  def self.esv_api(passage)
    uri = self.esv_uri(passage)
    open(uri).read
  end
  #TODO: dry esv uri, instance method cannot be called in class method
  def self.esv_uri(passage)
    passage = passage.gsub(/\s/, "+")
    passage = passage.gsub(/\:/, "%3A")
    passage = passage.gsub(/\,/, "%2C")

    options = ["include-short-copyright=0",
               "output-format=plain-text",
               "include-passage-horizontal-lines=0",
               "include-passage-references=0",
               "include-headings=0",
               "include-footnotes=0",
               "include-verse-numbers=0",
               "include-first-verse-numbers=0",
               "include-heading-horizontal-lines=0"].join("&")
    base_url = "http://www.esvapi.org/v2/rest/passageQuery?key=IP"

    base_url + "&passage=#{passage}&#{options}"
  end
 
  def esv_passage
    uri = esv_uri
    open(uri).read
  end

  def category_names
    @category_names || categories.map(&:name).join(', ')
  end

  private
  def assign_categories
    if @category_names
      self.categories = @category_names.split(/,\s+/).map do |name|
        Category.find_or_create_by_name_and_user_id(name, self.user_id)
      end
    end
  end

  def esv_uri
    passage = self.ref
    passage = passage.gsub(/\s/, "+")
    passage = passage.gsub(/\:/, "%3A")
    passage = passage.gsub(/\,/, "%2C")

    options = ["include-short-copyright=0",
               "output-format=plain-text",
               "include-passage-horizontal-lines=0",
               "include-passage-references=0",
               "include-headings=0",
               "include-footnotes=0",
               "include-verse-numbers=0",
               "include-first-verse-numbers=0",
               "include-heading-horizontal-lines=0"].join("&")
    base_url = "http://www.esvapi.org/v2/rest/passageQuery?key=IP"

    base_url + "&passage=#{passage}&#{options}"
  end

end
