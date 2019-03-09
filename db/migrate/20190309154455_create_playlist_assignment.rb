class CreatePlaylistAssignment < ActiveRecord::Migration[5.2]
  def change
    create_table :playlist_assignments do |t|
      t.integer :playlist_id
      t.integer :playable_id
      t.string  :playable_type
      t.timestamps
    end
    add_index :playlist_assignments, [:playlist_id]
    add_index :playlist_assignments, [:playable_type, :playable_id]
  end
end
