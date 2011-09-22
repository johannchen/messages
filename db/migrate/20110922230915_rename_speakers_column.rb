class RenameSpeakersColumn < ActiveRecord::Migration
  def change
    rename_column :speakers, :chruch, :church
  end
end
