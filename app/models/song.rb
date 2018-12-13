class Song < ApplicationRecord
    # validates
    validates :title, presence: true
    # validates :ISRC, uniqueness: true

    # association
    has_and_belongs_to_many :albums, join_table: :albums_songs
    has_and_belongs_to_many :artists, join_table: :artist_songs
    has_and_belongs_to_many :playlists, join_table: :playlists_songs

    has_one :melody_copy
    has_one :lyric_copy
    has_one :producer_copy
    has_one :recording_copy

    mount_uploader :audio_file, MusicUploader

    acts_as_taggable 

    # def conver_gender
    #     genres = {"10": "流行", "11": "摇滚", "12": "民谣", "13": "电子", "14": "节奏布鲁斯", "15": "爵士",  "16: "轻音乐",  "17":  "嘻哈(说唱)",  "18":   "动漫",  "19":  "金属", 
    #         "20":  "朋克",  "21":  "世界音乐", "22":  "新世纪", "23":  "舞台 / 银幕 / 娱乐", "24":   "乡村", "25":  "雷鬼", 26:  "古典", 27:  "唱作人", "28":  "拉丁", "29":  "中国特色",
    #         "30":  "实验", "31":  "儿童", "32":  "有声书", "33":  "布鲁斯"}
    #     genres[self.genre]
    # end
end
