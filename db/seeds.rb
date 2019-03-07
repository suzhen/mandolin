# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# genreOptions =  [[10, '流行', 'Pop'], 
#                  [11, '摇滚', 'Rock'],
#                  [12, '民谣', 'Folk'],
#                  [13, '电子', 'Electronic'],
#                  [14, '节奏布鲁斯', 'R&B'],
#                  [15, '爵士', 'Jazz'], 
#                  [16, '轻音乐', 'Easy Listening'], 
#                  [17, '嘻哈(说唱) ', 'Hip Hop'], 
#                  [18, '动漫', 'ACG'], 
#                  [19, '布鲁斯', 'Blues'], 
#                  [20, '金属', 'Metal'], 
#                  [21, '朋克', 'Punk'], 
#                  [22, '世界音乐', 'World Music'], 
#                  [23, '新世纪', 'New Age'],
#                  [24, '舞台 / 银幕 / 娱乐', 'Stage & Screen & Entertainment'],
#                  [25, '乡村', 'Country' ],
#                  [26, '雷鬼', 'Reggae'], 
#                  [27, '古典', 'Classical'],
#                  [28, '唱作人', 'Singer-Songwriter'], 
#                  [29, '拉丁', 'Latin'], 
#                  [30, '中国特色', 'Chinese Characteristic'], 
#                  [31, '实验', 'Experimental'], 
#                  [32, '儿童', 'Children'], 
#                  [33, '有声书', 'Audio Book'],
#                  [34, '其它', 'Other']] 

# genreOptions.each do |genre|
#     Genre.create(:code=>genre[0], :chinese_name=>genre[1], :english_name=>genre[2])
# end

# Artist.create(:name => "佚名", :gender => "0", :location => "中国" )

# User.create(:email => "admin@nandor.cn", :password => "superadmin" )

User.create(:email => "szhuo@tpgchinamusic.com", :password => "P@55w0rd" )