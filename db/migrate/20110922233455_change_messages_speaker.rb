class ChangeMessagesSpeaker < ActiveRecord::Migration
  change_table :messages do |t| 
    t.remove :speaker
    t.integer :speaker_id
  end
end
