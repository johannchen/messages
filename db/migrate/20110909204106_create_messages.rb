class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :title
      t.date :mdate
      t.string :speaker
      t.text :summary
      t.string :url

      t.timestamps
    end
  end
end
