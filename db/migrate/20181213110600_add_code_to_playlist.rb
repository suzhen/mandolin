class AddCodeToPlaylist < ActiveRecord::Migration[5.2]
  def change
    add_column :playlists, :code, :string
  end
end
