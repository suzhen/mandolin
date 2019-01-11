class AddOwnCopiesToSongs < ActiveRecord::Migration[5.2]
  def change
    add_column :songs, :own_lyric_copies, :integer, :comment=>"是否有词版权"
    add_column :songs, :own_melody_copies, :integer, :comment=>"是否有曲版权"
    add_column :songs, :own_producer_copies, :integer, :comment=>"是否有表演者版权"
    add_column :songs, :own_recording_copies, :integer, :comment=>"是否有录音版权"
  end
end
