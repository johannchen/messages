class AddUserIDtoTables < ActiveRecord::Migration
  def change
    add_column :categories, :user_id, :integer
    add_column :speakers, :user_id, :integer
    add_column :verses, :user_id, :integer
  end
end
