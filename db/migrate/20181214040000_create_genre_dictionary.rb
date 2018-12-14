class CreateGenreDictionary < ActiveRecord::Migration[5.2]
  def change
    create_table :dict_genres, id: false do |t|
      t.integer :code
      t.string :chinese_name
      t.string :english_name
    end
  end
end
