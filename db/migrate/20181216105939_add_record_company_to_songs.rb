class AddRecordCompanyToSongs < ActiveRecord::Migration[5.2]
  def change
    add_column :songs, :record_company, :string
    add_column :songs, :publisher, :string
    add_column :songs, :library_name, :string
  end
end
