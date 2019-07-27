class ChangeExpireDateOfSong < ActiveRecord::Migration[5.2]
  def change
    change_column :contracts, :auth_duration, :datetime
  end
end
