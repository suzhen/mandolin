class ChangeNameToCopyies < ActiveRecord::Migration[5.2]
  def change
    rename_column :lyric_copies, :disctrict, :district
    rename_column :melody_copies, :disctrict, :district
    rename_column :producer_copies, :disctrict, :district
    rename_column :recording_copies, :disctrict, :district
  end
end
