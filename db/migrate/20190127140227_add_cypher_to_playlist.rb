class AddCypherToPlaylist < ActiveRecord::Migration[5.2]
  def change
    add_column :playlists, :cypher, :string
  end
end
