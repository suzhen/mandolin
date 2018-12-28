class RenameNameColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :lyric_copies, :lyricists, :name
    rename_column :melody_copies, :composers, :name
  end
end
