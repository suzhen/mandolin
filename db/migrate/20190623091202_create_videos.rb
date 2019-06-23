class CreateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos do |t|
      t.string :version, :comment=>"版本号"
      t.string :grouping, :comment=>"类别"
      t.string :copyright, :comment=>"著作权比例"
      t.string :producer, :comment=>"制片人"
      t.date :release_date, :comment=>"发行日期"
      t.date :recording_date, :comment=>"录制日期"
      t.string :duration, :comment=>"时长"
      t.string :district, :comment=>"地区"
      t.string :definition, :comment=>"清晰度"
      t.string :copyright_company, :comment=>"版权公司"
      t.string :origin_copyright, :comment=>"原始版权方"
      t.string :ISRC
      t.string :priority, :comment=>"是否重点"
      t.string :media_file, :comment=>"上传文件"
      t.references :song
      t.timestamps
    end
  end
end
