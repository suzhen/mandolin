class CreateBoilerplates < ActiveRecord::Migration[5.2]
  def change
    create_table :boilerplates do |t|
      t.string :name
      t.string :download
      t.integer :count
      t.string :loader

      t.timestamps
    end
  end
end
