class ArtistsSongs < ActiveRecord::Migration[5.2]
  def change
    create_join_table :songs, :artist do |t|
      t.index :song_id
      t.index :artist_id
    end
  end
end
