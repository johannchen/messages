class CreateCategoriesMessages < ActiveRecord::Migration
  def change
    create_table :categories_messages, :id => false do |t|
      t.integer :category_id, :message_id
    end
  end
end
