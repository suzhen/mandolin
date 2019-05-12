class AddPdfToSongs < ActiveRecord::Migration[5.2]
  def change
    add_column :songs, :lyricist_cert, :string
    add_column :songs, :composer_cert, :string
    add_column :songs, :performer_cert, :string
    add_column :songs, :producer_cert, :string
    add_column :songs, :licence, :string
  end
end
