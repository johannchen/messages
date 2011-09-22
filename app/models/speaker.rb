class Speaker < ActiveRecord::Base
  has_many :messages
end
