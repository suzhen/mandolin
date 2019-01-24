class AddClassifyToSongs < ActiveRecord::Migration[5.2]
  def change
    add_column :songs, :classification, :integer, :limit => 1, :comment=>"歌曲分类  1 正常 2 DEMO"
    add_index :songs, :classification
  end
end
