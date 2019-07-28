class ChangeBpmforDemo < ActiveRecord::Migration[5.2]
  def change
    change_column :demos, :bpm, :integer
  end
end
