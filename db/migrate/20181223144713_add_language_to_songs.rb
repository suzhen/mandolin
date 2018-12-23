class AddLanguageToSongs < ActiveRecord::Migration[5.2]
  def change
    add_column :songs, :language, :string, :comment=>"语种"
    add_column :songs, :producer, :string, :comment=>"制作人"
    add_column :songs, :recording_room, :string, :comment=>"录音工作室"
    add_column :songs, :mixer, :string, :comment=>"录音师"
    add_column :songs, :designer, :string, :comment=>"设计"
    add_column :songs, :ar, :string, :comment=>"艺人与制作部"
  end
end
