class ChangePlaylistIdInPlaylistUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :playlists_users, :playlist_id, :string
  end
end
