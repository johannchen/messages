class CreateVerse < ActiveRecord::Migration
  def change
    create_table :verses do |t|
      t.string :ref
    end

    create_table :messages_verses, :id => false  do |t|
      t.integer :message_id, :verse_id
    end
  end
end
