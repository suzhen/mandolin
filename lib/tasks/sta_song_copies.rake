task :statistics_copies => :environment do         #cmd 命令行中执行 rake study_rake 开始执行脚本，task是Rake最重要的方法.它的方法定义是:task(args, &block).任务体是一个block。
   @songs = Song.all
   @songs.each do |song|
      song.genre = 10
      song.save
   end
end