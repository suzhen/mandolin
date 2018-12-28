class AddUpcAndArrangerToSongs < ActiveRecord::Migration[5.2]
  def change
    add_column :songs, :UPC, :string, :comment=>"UPC"
    add_column :songs, :arranger, :string, :comment=>"编曲者"
  end
end
