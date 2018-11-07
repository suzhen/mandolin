class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.string :title
      t.text :lyrics
      t.date :release_date
      t.integer :genre
      t.string :grouping
      t.string :composers
      t.string :lyricists
      t.string :audio_file
      t.string :ISRC
      t.string :duration
      t.string :ownership
      t.timestamps null: false
    end
  end
end
