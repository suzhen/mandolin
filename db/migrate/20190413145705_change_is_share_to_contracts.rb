class ChangeIsShareToContracts < ActiveRecord::Migration[5.2]
  def change
    change_column :contracts, :is_shared, :string
  end
end
