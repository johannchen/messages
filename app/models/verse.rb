class Verse < ActiveRecord::Base
  has_and_belongs_to_many :messages

  require 'open-uri'
  
  def esv_passage
    uri = esv_uri
    open(uri).read
  end

  private
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
               "include-heading-horizontal-lines=0"].join("&")
    base_url = "http://www.esvapi.org/v2/rest/passageQuery?key=IP"

    base_url + "&passage=#{passage}&#{options}"
  end
end
