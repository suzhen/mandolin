task :copy_release_date => :environment do         #cmd 命令行中执行 rake study_rake 开始执行脚本，task是Rake最重要的方法.它的方法定义是:task(args, &block).任务体是一个block。
    Song.all.each do |song|
        if song.albums.present?
            song.release_date = song.albums[0].release_date
            song.save
        end
    end   
end