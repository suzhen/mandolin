class ChangeIdInPlaylistAssignment < ActiveRecord::Migration[5.2]
  def change
    change_column :playlist_assignments, :playlist_id, :string
  end
end
