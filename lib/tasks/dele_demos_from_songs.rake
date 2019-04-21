task :del_demos_from_songs => :environment do         #cmd 命令行中执行 rake del_demos_from_songs 开始执行脚本
    @songs = Song.where(:classification=>2)
    @songs.destroy_all
 end