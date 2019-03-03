class CreateJoinTableDemosAndArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :demoreferences do |t|
      t.integer :artist_id
      t.integer :demo_id
      t.string :related_type
      t.timestamps
    end

    add_index :demoreferences, [:artist_id, :demo_id]
  end
end
