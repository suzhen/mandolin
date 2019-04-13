class AddContractTypeToContracts < ActiveRecord::Migration[5.2]
  def change
    add_column :contracts, :contract_type, :string
    add_column :contracts, :label, :string
  end
end
