require 'digest'
task :secret_upyun=> :environment do         #cmd 命令行中执行 rake study_rake 开始执行脚本，task是Rake最重要的方法.它的方法定义是:task(args, &block).任务体是一个block。
    @song = Song.find_by(:title => "测试歌曲")
    # @song.audio_file.content_type = "suzhen"
    # File.open('./lib/tasks/吴克群-残废.mp3') do |f|
    #     @song.audio_file = f
    # end
    # @song.save!
    # puts @song.audio_file.content_type

    u = "/" + @song.audio_file.path
    now =  DateTime.now.to_i
    token = ""
    etime = now + 120
    puts "URL:" + @song.audio_file.url
    puts "url:" + u
    puts "secret:" + token
    puts "etime:" + etime.to_s
    yys = "#{token}&#{etime}&#{u}"
    puts "(token & etime & u):" + yys
    sign = Digest::MD5.hexdigest(yys)

    upt =  sign[12, 8] + etime.to_s

    us =  "http://" + @song.audio_file.url
    
    s = us + "?_upt=#{upt}"
    
    puts "sign:" + sign
    puts "sign[8]:" + sign[12, 8]
    puts "upt:" + upt
    puts us
    puts s
end

# fae0e1eb 2c78 40c063a3 7a7b  eecf19cb