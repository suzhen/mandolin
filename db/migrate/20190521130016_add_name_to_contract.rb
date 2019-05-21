class AddNameToContract < ActiveRecord::Migration[5.2]
  def change
    add_column :contracts, :name, :string, :comment=>"合同名称"
    add_column :contracts, :time_limit, :string, :comment=>"合同期限"
    add_column :contracts, :expire_date, :datetime, :comment=>"合同到期日"
    change_column :contracts, :auth_duration, :string, :comment=>"授权期限"
    add_column :contracts, :auth_right, :string, :comment=>"授权权利"
  end
end
