class Addexpiretoplaylists < ActiveRecord::Migration[5.2]
  def change
    add_column :playlists, :expire, :datetime
  end
end
