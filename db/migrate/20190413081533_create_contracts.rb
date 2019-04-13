class CreateContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :contracts do |t|
      t.string :auth_party
      t.string :op_type
      t.decimal :auth_fee
      t.integer :auth_duration
      t.string :payment_type
      t.string :auth_platform
      t.string :auth_location
      t.string :op_content
      t.string :song_count
      t.string :list_type
      t.string :auth_type
      t.boolean :is_shared
      t.text :auth_bussiness
      t.text :extend_terms
      t.timestamps
    end
  end
end
