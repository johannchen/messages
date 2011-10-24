class AddTimestampsToVerses < ActiveRecord::Migration
  def change
    change_table :verses do |t|
      t.timestamps
      t.datetime :memorized_at
      t.rename :favor, :favorite
    end
  end
end
