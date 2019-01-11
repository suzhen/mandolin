class AddBusinessToSong < ActiveRecord::Migration[5.2]
  def change
    add_column :songs, :business, :string, :comment=>"商业范围"
  end
end
