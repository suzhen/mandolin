class AddCreateJoinTablePlaylistsAndUsers < ActiveRecord::Migration[5.2]
  def change
    create_join_table :playlists, :users do |t|
      t.index :playlist_id
      t.index :user_id
    end
  end
end
