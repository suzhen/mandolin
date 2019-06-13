class AddRightsTypeToRecordingCopies < ActiveRecord::Migration[5.2]
  def change
    add_column :recording_copies, :rights_type, :string
    add_column :recording_copies, :scope_business, :string
    add_column :recording_copies, :authorization, :string
  end
end
