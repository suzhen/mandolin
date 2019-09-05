class AddAllowdownloadToPlaylists < ActiveRecord::Migration[5.2]
  def change
    add_column :playlists, :allow_download, :boolean
    add_column :playlists, :has_password, :boolean
  end
end
