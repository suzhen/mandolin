class RemoveColumnsFromDemo < ActiveRecord::Migration[5.2]
  def change
    remove_column :demos, :writers
    remove_column :demos, :pitched_artists
    remove_column :demos, :hold_by
    remove_column :demos, :cut_by
    remove_column :demos, :genres
    add_column :demos, :genre, :integer
  end
  add_index :demos, [:title, :source, :mfd, :year, :bpm]
end
