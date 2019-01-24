class AddIndexToSongs < ActiveRecord::Migration[5.2]
  def change
    add_index :songs, :title
    add_index :songs, :genre
    add_index :songs, :ownership
    add_index :songs, :own_lyric_copies
    add_index :songs, :own_melody_copies
    add_index :songs, :own_producer_copies
    add_index :songs, :own_recording_copies
    add_index :songs, :composers
    add_index :songs, :lyricists
  end
end
