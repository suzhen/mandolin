require 'roo'

def parse_name(name)
    if name.nil?
        return "佚名"
    end
    if name.include? "+"
        return name.split("+")
    end
    if name.include? "＋"
        return name.split("＋")
    end
    if name.include? "/"
        return name.split("/")
    end
    if name.include? "|"
        return name.split("|")
    end
    return name
end

def parse_album_name(name)
    if name.blank?
        return "暂无"
    end
    return name
end

def parse_album_release_date(date)
    return date
end

def parse_share(share)
    if share.class == String
        share = share.gsub(/[^\d]/, '').to_f
        return share / 100
    end
    if share.class == Float || share.class  == Integer
        return share
    end
end

def parse_artists(default_sheet, first_row, last_row)
    names = []
    (first_row..last_row).each do |n|
        begin
            r = default_sheet.row(n)
            artist_name1 = parse_name(r[4]) if r[4].present?
            artist_name2 = parse_name(r[16]) if r[16].present?
            names << artist_name1
            names << artist_name2
        rescue
            puts r[4] 
            puts r[16]
            puts "----------------"
        end
    end
    return names
end

def parse_info(default_sheet, first_row, last_row, ownership)
    (first_row..last_row).each do |n|
        begin
            r = default_sheet.row(n)
            # 歌典基本信息
            song_name = r[2]
            record_company = r[6]
            composers = r[8]
            lyricists = r[10]
            publisher = r[12]
            language = r[14]
            producer = r[19]
            recording_room = r[20]
            mixer = r[21]
            designer = r[22]
            ar = r[23]
            upc = r[17]
            arranger = r[18]
            isrc = r[24]
            @song = Song.new(:title => song_name)
            @song.record_company = record_company
            @song.composers = composers
            @song.lyricists = lyricists
            @song.publisher = publisher
            @song.language = language
            @song.ownership = ownership
            @song.UPC = upc
            @song.ISRC = isrc
            @song.producer = producer
            @song.recording_room = recording_room
            @song.mixer = mixer
            @song.ar = ar
            @song.arranger = arranger
            @song.designer = designer
            # 词版权
            lyric_copy_name = r[26]
            lyric_copy_agreement_number = r[27]
            lyric_copy_disctrict = r[28]
            lyric_copy_share = parse_share(r[11])
            @song.lyric_copy.name = lyric_copy_name
            @song.lyric_copy.share = lyric_copy_share
            @song.lyric_copy.agreement_number = lyric_copy_agreement_number
            @song.lyric_copy.disctrict = lyric_copy_disctrict
            # 曲版权
            melody_copy_name = r[30]
            melody_copy_agreement_number = r[31]
            melody_copy_disctrict = r[32]
            melody_copy_share = parse_share(r[9])
            @song.melody_copy.name = melody_copy_name
            @song.melody_copy.share = melody_copy_share
            @song.melody_copy.agreement_number = melody_copy_agreement_number
            @song.melody_copy.disctrict = melody_copy_disctrict
            # 表演者版权
            producer_copy_name = r[34]
            producer_copy_agreement_number = r[35]
            producer_copy_disctrict = r[36]
            producer_copy_share = parse_share(r[5])
            @song.producer_copy.name = producer_copy_name
            @song.producer_copy.share = producer_copy_share
            @song.producer_copy.agreement_number = producer_copy_agreement_number
            @song.producer_copy.disctrict = producer_copy_disctrict
            # 录音制作版权
            recording_copy_name = r[38]
            recording_copy_agreement_number = r[39]
            recording_copy_disctrict = r[40]
            recording_copy_share = parse_share(r[7])
            @song.recording_copy.name = recording_copy_name
            @song.recording_copy.agreement_number = recording_copy_agreement_number
            @song.recording_copy.disctrict = recording_copy_disctrict
            # 其它信息
            other_info_public = r[41]
            other_info_priority = r[42]
            other_info_remark = r[43]
            @song.other_info.publish_platform = other_info_public
            @song.other_info.priority = other_info_priority
            @song.other_info.remark = other_info_remark
            @song.save
            # 表演艺术家关联
            artist_ids = []
            artist_names = parse_name(r[16])
            if artist_names.class == Array
                artist_ids = artist_names.map {|name|  Artist.find_by(:name=>name).id}
            else
                artist_ids = [Artist.find_by(:name=>artist_names).id]
            end
            @song.artist_ids = artist_ids
            # album进行关联
            album_name = parse_album_name(r[3])
            album_release_date = parse_album_release_date(r[13])
            album_artist_names = parse_name(r[4])
            if album_artist_names.class == Array
                album_artist = Artist.find_by(:name=>album_artist_names[0])
            else
                album_artist = Artist.find_by(:name=>album_artist_names)
            end
            album = album_artist.albums.find_or_create_by(:title=>album_name, :release_date=>album_release_date)
            @song.albums << album

            @song.save
        rescue
            puts r[4]
        end
    end

end

# 第一步导入所有艺人
task :process_artists => :environment do         #cmd 命令行中执行 rake study_rake 开始执行脚本，task是Rake最重要的方法.它的方法定义是:task(args, &block).任务体是一个block。
    ods = Roo::Spreadsheet.open('./lib/tasks/Tianhao.xlsx')
    
    names1 = parse_artists(ods.sheet(1), 5, 442)

    names2 = parse_artists(ods.sheet(2), 5, 238)

    names3 = parse_artists(ods.sheet(3), 5, 864)

    names = names1 + names2 + names3

    names = names.flatten.uniq.compact

    names.each do |name|
        Artist.find_or_create_by(:name=>name)
    end
end

# 第二步导入所有歌曲
task :process_song_info => :environment do         #cmd 命令行中执行 rake study_rake 开始执行脚本，task是Rake最重要的方法.它的方法定义是:task(args, &block).任务体是一个block。
    ods = Roo::Spreadsheet.open('./lib/tasks/Tianhao.xlsx')
    parse_info(ods.sheet(1), 5, 442, "自有词曲+录音")

    parse_info(ods.sheet(2), 5, 238, "自有录音")

    parse_info(ods.sheet(3), 5, 864, "代理")
end