CarrierWave.configure do |config|
    config.storage = :upyun
    config.upyun_username = 'rc002'
    config.upyun_password = 'sz1300715'
    config.upyun_bucket = 'song-nandor'
    config.upyun_bucket_host = "song-nandor.test.upcdn.net"
end