class ChangeIdInPlaylist < ActiveRecord::Migration[5.2]
  def change
    change_column :playlists, :id, :string
  end
end
