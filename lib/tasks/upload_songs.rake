require "pathname"
def traverse_dir(file_path, &block)
    if File.directory? file_path
        Dir.foreach(file_path) do |file|
            if file !="." and file !=".."
                traverse_dir(file_path+"/"+file, &block)
            end
        end
    else
        if File.extname(file_path) == ".mp3"
            block.call file_path
        end
    end
end

# 上传艺术家
task :upload_artists => :environment do         #cmd 命令行中执行 rake study_rake 开始执行脚本，task是Rake最重要的方法.它的方法定义是:task(args, &block).任务体是一个block。
    artists = []
    traverse_dir("/Volumes/TPG Music/音源+mv") do |file_path|
        song_basename = File.basename(file_path, ".mp3") 
        song_name, artist_name = song_basename.split("-")        
        if artist_name.index('+') 
            ans = artist_name.split("+")
        else
            artists << artist_name
        end
    end
    artists = artists.flatten.uniq
    Rails.logger.info "任务结束，应增#{artists.length}个艺术家。"
    artists.each do |artist|
       Artist.find_or_create_by(:name =>artist)
    end
end

# 上传歌曲
task :upload_songs => :environment do         #cmd 命令行中执行 rake study_rake 开始执行脚本，task是Rake最重要的方法.它的方法定义是:task(args, &block).任务体是一个block。
    num = 1
    traverse_dir("/Volumes/TPG Music/音源+mv") do |file_path|
        song_basename = File.basename(file_path, ".mp3") 
        song_name, artist_name = song_basename.split("-") 
        @artist = Artist.find_by(:name => artist_name)     
        if @artist
           @song = Song.create(:title => song_name)
           File.open(file_path) do |f|
             @song.audio_file = f
           end
        #    @artist.songs << @song 
           @artist.save()
        end
        Rails.logger.info "开始上传第#{num}首歌,歌名是《#{song_basename}》。"
        num += 1
    end
end

task :upload_albums => :environment do         #cmd 命令行中执行 rake study_rake 开始执行脚本，task是Rake最重要的方法.它的方法定义是:task(args, &block).任务体是一个block。
    o = {}
    traverse_dir("/Volumes/TPG Music/音源+mv") do |file_path|
        Dir.chdir File.dirname(file_path)
        ds = file_path.split(File::SEPARATOR)
        belongs_to_artist = ds[4]
        album_name = ds[5].split("-")[1]
        belongs_to_artist.strip!
        album_name.strip!
        album_name.gsub!(/[《》]/, '')
        song_basename = File.basename(file_path, ".mp3")
        song_name, artist_name = song_basename.split("-")
        if artist_name.index('+') 
            artist_name = artist_name.split("+")
        else
            artist_name = [artist_name]
        end
        if o[belongs_to_artist].nil?
            o[belongs_to_artist] = {}
        end
        if o[belongs_to_artist][album_name].nil?
            o[belongs_to_artist][album_name] = [] 
        end
        unless o[belongs_to_artist][album_name].include? song_name
            o[belongs_to_artist][album_name] << {"song_name": song_name, "artist_name": artist_name}
        end 
    end
    # puts o
    o.each do |belongs_to_artist, album|
        album.each do |album_name, songs|
          @album = Album.create(:title=>album_name)
          @bt_artist = Artist.find_or_create_by(:name=>belongs_to_artist)
          songs.each do |song|
            @song = Song.find_by(:title => song[:song_name])
            if @song
                @album.songs << @song
                @bt_artist.albums << @album
                @bt_artist.save
                belongs_to_artist
                song[:artist_name].each do |artist|
                    @artist = Artist.find_by(:name=>artist)
                    unless @artist
                        @artist = Artist.create(:name=>artist)  
                    end
                    @artist.songs << @song
                    @artist.save
                end
            end
          end
        end
    end
end


# 上传Demo
task :upload_demo => :environment do         #cmd 命令行中执行 rake study_rake 开始执行脚本，task是Rake最重要的方法.它的方法定义是:task(args, &block).任务体是一个block。
    num = 1
    traverse_dir("/Volumes/TPG Music/DEMO") do |file_path|
        song_basename = File.basename(file_path, ".mp3")
        @song = Song.create(:title => song_name)
        File.open(file_path) do |f|
            @song.audio_file = f
        end
        Rails.logger.info "开始上传第#{num}首歌,歌名是《#{song_basename}》。"
        num += 1
    end
    puts num
end



