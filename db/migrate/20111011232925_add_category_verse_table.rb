class AddCategoryVerseTable < ActiveRecord::Migration
  def change
    create_table :categories_verses, :id => false do |t|
      t.integer :category_id, :verse_id
    end 
  end
end
