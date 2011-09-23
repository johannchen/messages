class AddListenToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :listened_on, :date
    add_column :messages, :user_id, :integer
  end
end
