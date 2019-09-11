class AddPositonToPlaylistAssignments < ActiveRecord::Migration[5.2]
  def change
    add_column :playlist_assignments, :position, :integer, :default=>0
  end
end
