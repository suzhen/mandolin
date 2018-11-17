class CreateJoinTablePlaylistsAndSongs < ActiveRecord::Migration[5.2]
  def change
    create_join_table :playlists, :songs do |t|
      t.index :song_id
      t.index :playlist_id
    end
  end
end
