class AddRightsTypeToMelodyCopies < ActiveRecord::Migration[5.2]
  def change
    add_column :melody_copies, :rights_type, :string
  end
end
