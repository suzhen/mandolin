class AddCreatorIdToPlaylists < ActiveRecord::Migration[5.2]
  def change
    add_column :playlists, :creator_id, :integer
  end
end
