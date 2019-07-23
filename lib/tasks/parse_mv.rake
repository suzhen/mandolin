require 'roo'
require 'csv' 

FILE_NAME = "./lib/tasks/mv.xlsx"

def parse_mv(default_sheet, first_row, last_row)
    names = []
    (first_row..last_row).each do |n|
        r = default_sheet.row(n)
        song_title = r[2]
        song_ISRC = r[10]
        
        song_language = r[4]

        mv_version = r[1]
        mv_copyright = r[5]
        mv_release_date = r[7]
        mv_grouping = r[8]
        mv_district = r[12]
        mv_priority = r[13]=="是" ? 1 : 0
        mv_copyright_company = r[16]
        mv_origin_copyright = r[17]
        # mv_duration = Time.at(r[14]) 
        mv_duration = r[14]
        @song = Song.find_by(:title=>song_title)
        @mv = Video.new(:version=>mv_version, 
                        :copyright=>mv_copyright, 
                        :release_date=>mv_release_date, 
                        :grouping =>mv_grouping,
                        :district=>mv_district,
                        :priority=>mv_priority,
                        :copyright_company=>mv_copyright_company,
                        :origin_copyright=>mv_origin_copyright,
                        :duration=>mv_duration,
                        )

        if @song.present?
            @song.ISRC = song_ISRC
            @mv.song_id = @song.id
            @song.save
            @mv.save
        else
            puts "没有<#{r[2]}>这首歌"
            @song = Song.new(:title=>song_title, :ISRC=>song_ISRC, :language=>song_language)
            @song.save
            @mv.song_id = @song.id
            @mv.save
        end
    end
    return names
end

task :process_mvs => :environment do 
    ods = Roo::Spreadsheet.open(FILE_NAME)
    song_name = parse_mv(ods.sheet(1), 4, 159)
end

