class AddRecordCompanyToSongs < ActiveRecord::Migration[5.2]
  def change
    add_column :songs, :record_company, :string, :comment=>"唱片公司"
    add_column :songs, :publisher, :string, :comment=>"发行公司"
    add_column :songs, :library_name, :string, :comment=>"曲库名称"
  end
end
