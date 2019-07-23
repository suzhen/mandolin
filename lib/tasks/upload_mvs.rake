require "pathname"
def traverse_mv_dir(file_path, &block)
    if File.directory? file_path
        Dir.foreach(file_path) do |file|
            if file !="." and file !=".."
                traverse_mv_dir(file_path+"/"+file, &block)
            end
        end
    else
        if [".mp4", ".mov", ".wmv", ".mpg", ".MPG"].include? File.extname(file_path)
            block.call file_path
        end
    end
end


# 上传歌曲
task :upload_mvs => :environment do         #cmd 命令行中执行 rake study_rake 开始执行脚本，task是Rake最重要的方法.它的方法定义是:task(args, &block).任务体是一个block。
    num = 1
    traverse_mv_dir("/Volumes/TOSHIBA EXT/MV物料/MV") do |file_path|
        song_basename = File.basename(file_path, ".*") 
        name_index = song_basename.index(/ /) 
        artist_index = song_basename.index(/-|_|\(/)
        mv_name = ""
        if name_index.class != NilClass
            if artist_index.class == NilClass
                mv_name = song_basename[name_index..-1]
            else
                mv_name = song_basename[name_index..artist_index-1]
            end
        end
        @mv = Video.find_by(:version=>mv_name.strip)
        if @mv.present?
            File.open(file_path) do |f|
                @mv.media_file = f
            end
            @mv.save
        else
            puts "'#{song_basename}'"
        end
        # @artist = Artist.find_by(:name => artist_name)     
        # if @artist
        #    @song = Song.create(:title => song_name)
        #    File.open(file_path) do |f|
        #      @song.audio_file = f
        #    end
        # #    @artist.songs << @song 
        #    @artist.save()
        # end
        Rails.logger.info "开始上传第#{num}首MV,MV名是《#{song_basename}》。"
        num += 1
    end
end
