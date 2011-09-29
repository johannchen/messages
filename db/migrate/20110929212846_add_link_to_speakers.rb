class AddLinkToSpeakers < ActiveRecord::Migration
  def change
    add_column :speakers, :link, :string
  end
end
