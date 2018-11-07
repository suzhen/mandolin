class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.string :title
      t.date :release_date
      t.string :variety
      t.string :artwork
      t.string :ISBN
      t.text :introduction
      t.timestamps
    end
  end
end
