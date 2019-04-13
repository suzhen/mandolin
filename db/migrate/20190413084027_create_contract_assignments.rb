class CreateContractAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :contract_assignments do |t|
      t.integer :contract_id
      t.integer :contractable_id
      t.string :contractable_type

      t.timestamps
    end
    add_index :contract_assignments, [:contract_id], :name => 'con_asg_conid_index'
    add_index :contract_assignments, [:contractable_type, :contractable_id], :name => 'con_asg_abletype_ableid_index'
  end
end
