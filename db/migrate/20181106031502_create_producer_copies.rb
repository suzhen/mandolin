class CreateProducerCopies < ActiveRecord::Migration[5.2]
  def change
    create_table :producer_copies do |t|
      t.string :name
      t.float :share
      t.references :song, foreign_key: true
      t.timestamps null: false
    end
  end
end
