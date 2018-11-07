class CreateArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :artists do |t|
      t.string :name
      t.integer :gender
      t.string :location
      t.timestamps null: false
      t.timestamps
    end
  end
end
