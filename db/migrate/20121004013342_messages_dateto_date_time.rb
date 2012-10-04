class MessagesDatetoDateTime < ActiveRecord::Migration
  def change
    change_column :messages, :listened_on, :datetime
    change_column :messages, :mdate, :datetime
  end
end
