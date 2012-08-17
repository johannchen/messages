class AddContentToVerses < ActiveRecord::Migration
  def change
    add_column :verses, :content, :text
    add_column :verses, :memorized, :integer, default: 0
    rename_column :verses, :memorized_at, :last_memorized_at
  end
end
