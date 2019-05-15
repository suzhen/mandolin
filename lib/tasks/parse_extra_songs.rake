require 'roo'
require 'csv' 

FILE_NAME = "./lib/tasks/songs.xlsx"

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
        res = share / 100
    end
    if share.class == Float || share.class  == Integer
        res = share
    end
    res.blank? ? nil : res > 1 ? nil : res
end

def parse_artists(default_sheet, first_row, last_row)
    names = []
    (first_row..last_row).each do |n|
        begin
            r = default_sheet.row(n)
            artist_name = parse_name(r[5]) if r[5].present?
            names << artist_name
        rescue
            puts r[4] 
            puts "----------------"
        end
    end
    return names
end

def parse_date(date)
    if date.present?
        begin
            date.strip!
            date = DateTime.strptime(date, '%Y.%m.%d')
        rescue
            begin
                date = DateTime.strptime(date, '%Y-%m-%d')
            rescue
                begin
                    date = DateTime.strptime(date, '%Y/%m/%d')
                rescue
                    begin
                        date = DateTime.strptime(date, '%Y年%m月%d日')
                    rescue
                        date = nil
                    end
                end 
            end
        end
        date  
    end
end

def parse_info(default_sheet, first_row, last_row, ownership)
    (first_row..last_row).each do |n|
        begin
            r = default_sheet.row(n)
            # 歌典基本信息
            song_name = r[3]
            record_company = r[7]
            composers = r[9]
            lyricists = r[11]
            publisher = r[13]
            language = r[15]
            arranger = r[18]
            producer = r[19]
            recording_room = r[20]
            mixer = r[21]
            designer = r[22]
            ar = r[23]
            isrc = r[24]
            upc = r[25]
            @song = Song.new(:title => song_name)
            @song.record_company = record_company
            @song.composers = composers
            @song.lyricists = lyricists
            @song.publisher = publisher
            @song.language = language
            # @song.ownership = ownership
            @song.UPC = upc
            @song.ISRC = isrc
            @song.producer = producer
            @song.recording_room = recording_room
            @song.mixer = mixer
            @song.ar = ar
            @song.arranger = arranger
            @song.designer = designer
            # 词版权
            lyric_copy_op = r[26]
            lyric_copy_sp = r[27]
            lyric_copy_agreement_number = r[28]
            lyric_copy_disctrict = r[29]
            lyric_copy_share = parse_share(r[12])
            lyric_copy_end = r[30]
            lyric_copy_end = parse_date(lyric_copy_end) 
            @song.lyric_copies.build(:op=>lyric_copy_op, :sp=>lyric_copy_sp, :agreement_number=>lyric_copy_agreement_number, :district=>lyric_copy_disctrict, :share=>lyric_copy_share, :end_date=>lyric_copy_end)
            # 曲版权
            melody_copy_op = r[31]
            melody_copy_sp = r[32]
            melody_copy_agreement_number = r[33]
            melody_copy_disctrict = r[34]
            melody_copy_share = parse_share(r[10])
            melody_copy_end = r[35]
            melody_copy_end = parse_date(melody_copy_end)
            @song.melody_copies.build(:op=>melody_copy_op, :sp=>melody_copy_sp, :agreement_number=>melody_copy_agreement_number, :district=>melody_copy_disctrict, :share=>melody_copy_share, :end_date=>melody_copy_end)
            # 表演者版权
            producer_copy_name = r[36]
            producer_copy_agreement_number = r[37]
            producer_copy_disctrict = r[38]
            producer_copy_share = parse_share(r[6])
            producer_copy_end = r[39]
            producer_copy_end = parse_date(producer_copy_end)
            @song.producer_copies.build(:name=>producer_copy_name, :agreement_number=>producer_copy_agreement_number, :district=>producer_copy_disctrict, :share=>producer_copy_share, :end_date=>producer_copy_end)
            # 录音制作版权
            recording_copy_name = r[40]
            recording_copy_agreement_number = r[41]
            recording_copy_disctrict = r[42]
            recording_copy_share = parse_share(r[8])
            recording_copy_end = r[43]
            recording_copy_end = parse_date(recording_copy_end)
            @song.recording_copies.build(:name=>recording_copy_name, :agreement_number=>recording_copy_agreement_number, :district=>recording_copy_disctrict, :share=>recording_copy_share, :end_date=>recording_copy_end)
            # 其它信息
            other_info_public = r[46]
            other_info_priority = r[47]
            other_info_remark = r[49]
            @song.other_info.publish_platform = other_info_public
            @song.other_info.priority = other_info_priority
            @song.other_info.remark = other_info_remark
            @song.save
            # 表演艺术家关联
            artist_ids = []
            artist_names = parse_name(r[5])
            if artist_names.class == Array
                artist_ids = artist_names.map {|name|  Artist.find_by(:name=>name).id}
            else
                artist_ids = [Artist.find_by(:name=>artist_names).id]
            end
            @song.artist_ids = artist_ids
            # album进行关联
            album_name = parse_album_name(r[4])
            album_release_date = parse_date(r[14])
            if artist_names.class == Array
                album_artist = Artist.find_by(:name=>artist_names[0])
            else
                album_artist = Artist.find_by(:name=>artist_names)
            end
            album = album_artist.albums.find_or_create_by(:title=>album_name, :release_date=>album_release_date)
            @song.albums << album
            @song.save
        rescue
            puts r[3]
        end
    end

end

# 第一步导入所有艺人
task :process_artists => :environment do         #cmd 命令行中执行 rake study_rake 开始执行脚本，task是Rake最重要的方法.它的方法定义是:task(args, &block).任务体是一个block。
    ods = Roo::Spreadsheet.open(FILE_NAME)
    
    names = parse_artists(ods.sheet(1), 5, 1575)

    names = names.flatten.uniq.compact

    names.each do |name|
        Artist.find_or_create_by(:name=>name)
    end
end

# 第二步导入所有歌曲
task :process_song_info => :environment do         #cmd 命令行中执行 rake study_rake 开始执行脚本，task是Rake最重要的方法.它的方法定义是:task(args, &block).任务体是一个block。
    ods = Roo::Spreadsheet.open(FILE_NAME)
    parse_info(ods.sheet(1), 5, 1575, "自有词曲+录音")
end

# 第三步导入UPYUN上歌的地址
task :process_upyun=> :environment do         #cmd 命令行中执行 rake study_rake 开始执行脚本，task是Rake最重要的方法.它的方法定义是:task(args, &block).任务体是一个block。
#     csv_text = File.read(FILE_NAME)
#     csv = CSV.parse(csv_text, :headers => true)
#     csv.each do |row|
#         o = row.to_hash
#         song_name =  o["title"]
#         audio_file = o["audio_file"]
#         @song = Song.find_by(:title => song_name)
#         if @song.present?
#             @song.audio_file = audio_file
#             @song.save!
#         end
#     end
end


task :upload_ag_songs => :environment do         #cmd 命令行中执行 rake study_rake 开始执行脚本，task是Rake最重要的方法.它的方法定义是:task(args, &block).任务体是一个block。
    num = 1
    traverse_dir("/Volumes/Untitled/seed/代理/音档") do |file_path|
        song_basename = File.basename(file_path, ".mp3") 
        # song_name, artist_name = song_basename.split("-") 
        # @artist = Artist.find_by(:name => artist_name)     
        # if @artist
        #    @song = Song.create(:title => song_name)
        #    File.open(file_path) do |f|
        #      @song.audio_file = f
        #    end
        # #    @artist.songs << @song 
        #    @artist.save()
        # end
        Rails.logger.info "开始上传第#{num}首歌,歌名是《#{song_basename}》。"
        num += 1
    end
    traverse_dir("/Volumes/Untitled/seed/代理第二期/音档") do |file_path|
        # song_basename = File.basename(file_path, ".mp3") 
        # song_name, artist_name = song_basename.split("-") 
        # @artist = Artist.find_by(:name => artist_name)     
        # if @artist
        #    @song = Song.create(:title => song_name)
        #    File.open(file_path) do |f|
        #      @song.audio_file = f
        #    end
        # #    @artist.songs << @song 
        #    @artist.save()
        # end
        # Rails.logger.info "开始上传第#{num}首歌,歌名是《#{song_basename}》。"
        num += 1
    end
    traverse_dir("/Volumes/Untitled/seed/自有") do |file_path|
        # song_basename = File.basename(file_path, ".mp3") 
        # song_name, artist_name = song_basename.split("-") 
        # @artist = Artist.find_by(:name => artist_name)     
        # if @artist
        #    @song = Song.create(:title => song_name)
        #    File.open(file_path) do |f|
        #      @song.audio_file = f
        #    end
        # #    @artist.songs << @song 
        #    @artist.save()
        # end
        # Rails.logger.info "开始上传第#{num}首歌,歌名是《#{song_basename}》。"
        num += 1
    end
end
