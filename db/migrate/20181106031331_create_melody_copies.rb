class CreateMelodyCopies < ActiveRecord::Migration[5.2]
  def change
    create_table :melody_copies do |t|
      t.string :name
      t.float :share
      t.date :begin_date
      t.date :end_date
      t.string :disctrict
      t.string :op
      t.string :sp
      t.references :song, foreign_key: true
      t.timestamps null: false
    end
  end
end
