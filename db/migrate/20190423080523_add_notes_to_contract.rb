class AddNotesToContract < ActiveRecord::Migration[5.2]
  def change
    add_column :contracts, :notes, :text
    change_column :contracts, :auth_duration, :text
    change_column :contracts, :payment_type, :text
    change_column :contracts, :auth_bussiness, :text
    change_column :contracts, :op_content, :text
  end
end
