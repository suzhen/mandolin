class AddRightsTypeToLyricCopies < ActiveRecord::Migration[5.2]
  def change
    add_column :lyric_copies, :rights_type, :string
  end
end
