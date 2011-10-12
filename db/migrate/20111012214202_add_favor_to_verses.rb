class AddFavorToVerses < ActiveRecord::Migration
  def change
    add_column :verses, :favor, :boolean
  end
end
