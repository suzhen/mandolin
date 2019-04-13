class CreateLibraryAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :library_assignments do |t|
      t.integer :library_id
      t.integer :libraryable_id
      t.string :libraryable_type

      t.timestamps
    end
    add_index :library_assignments, [:library_id]
    add_index :library_assignments, [:libraryable_type, :libraryable_id]
  end
end
