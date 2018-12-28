class CreateOtherInfo < ActiveRecord::Migration[5.2]
  def change
    create_table :other_infos do |t|
      t.string :publish_platform
      t.string :priority
      t.text :remark
      t.references :song, foreign_key: true
      t.timestamps null: false
    end
  end
end
