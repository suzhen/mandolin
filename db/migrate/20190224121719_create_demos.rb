class CreateDemos < ActiveRecord::Migration[5.2]
  def change
    create_table :demos do |t|
      t.string :title, :comment => "样本名称"
      t.string :source, :comment => "样本来源"
      t.string :writers, :comment => "样本来源"
      t.date :year, :comment => "样本年份"
      t.string :mfd
      t.string :genres, :comment => "流派"
      t.string :notes, :comment => "注解"
      t.string :bpm
      t.string :pitched_artists
      t.string :hold_by
      t.string :cut_by
      t.string :audio_file

      t.timestamps
    end
  end
end
