# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_07_27_111610) do

  create_table "albums", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.date "release_date"
    t.string "variety"
    t.string "artwork"
    t.string "ISBN"
    t.text "introduction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "artist_id"
  end

  create_table "albums_songs", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "song_id", null: false
    t.bigint "album_id", null: false
    t.index ["album_id"], name: "index_albums_songs_on_album_id"
    t.index ["song_id"], name: "index_albums_songs_on_song_id"
  end

  create_table "artist_songs", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "song_id", null: false
    t.bigint "artist_id", null: false
    t.index ["artist_id"], name: "index_artist_songs_on_artist_id"
    t.index ["song_id"], name: "index_artist_songs_on_song_id"
  end

  create_table "artists", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "gender"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "boilerplates", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "download"
    t.integer "count"
    t.string "loader"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contract_assignments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "contract_id"
    t.integer "contractable_id"
    t.string "contractable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "con_asg_conid_index"
    t.index ["contractable_type", "contractable_id"], name: "con_asg_abletype_ableid_index"
  end

  create_table "contracts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "auth_party"
    t.string "op_type"
    t.decimal "auth_fee", precision: 10
    t.datetime "auth_duration", comment: "授权期限"
    t.text "payment_type"
    t.string "auth_platform"
    t.string "auth_location"
    t.text "op_content"
    t.string "song_count"
    t.string "list_type"
    t.string "auth_type"
    t.string "is_shared"
    t.text "auth_bussiness"
    t.text "extend_terms"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "contract_type"
    t.string "label"
    t.text "notes"
    t.string "attachment_pdf"
    t.string "attachment_doc"
    t.string "name", comment: "合同名称"
    t.string "time_limit", comment: "合同期限"
    t.datetime "expire_date", comment: "合同到期日"
    t.string "auth_right", comment: "授权权利"
  end

  create_table "demoreferences", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "artist_id"
    t.integer "demo_id"
    t.string "related_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id", "demo_id"], name: "index_demoreferences_on_artist_id_and_demo_id"
  end

  create_table "demos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", comment: "样本名称"
    t.string "source", comment: "样本来源"
    t.date "year", comment: "样本年份"
    t.string "mfd"
    t.string "notes", comment: "注解"
    t.string "bpm"
    t.string "audio_file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "genre"
    t.index ["title", "source", "mfd", "year", "bpm"], name: "index_demos_on_title_and_source_and_mfd_and_year_and_bpm"
  end

  create_table "dict_genres", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "code"
    t.string "chinese_name"
    t.string "english_name"
  end

  create_table "libraries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "library_assignments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "library_id"
    t.integer "libraryable_id"
    t.string "libraryable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["library_id"], name: "index_library_assignments_on_library_id"
    t.index ["libraryable_type", "libraryable_id"], name: "index_library_assignments_on_libraryable_type_and_libraryable_id"
  end

  create_table "lyric_copies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.float "share"
    t.date "begin_date"
    t.date "end_date"
    t.string "district"
    t.string "op"
    t.string "sp"
    t.bigint "song_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "agreement_number", comment: "权利对应协议编号"
    t.string "rights_type"
    t.index ["song_id"], name: "index_lyric_copies_on_song_id"
  end

  create_table "melody_copies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.float "share"
    t.date "begin_date"
    t.date "end_date"
    t.string "district"
    t.string "op"
    t.string "sp"
    t.bigint "song_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "agreement_number", comment: "权利对应协议编号"
    t.string "rights_type"
    t.index ["song_id"], name: "index_melody_copies_on_song_id"
  end

  create_table "other_infos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "publish_platform"
    t.string "priority"
    t.text "remark"
    t.bigint "song_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "platform_authorization_expire"
    t.datetime "exclusive_authorization_expire"
    t.string "edition"
    t.index ["song_id"], name: "index_other_infos_on_song_id"
  end

  create_table "playlist_assignments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "playlist_id"
    t.integer "playable_id"
    t.string "playable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["playable_type", "playable_id"], name: "index_playlist_assignments_on_playable_type_and_playable_id"
    t.index ["playlist_id"], name: "index_playlist_assignments_on_playlist_id"
  end

  create_table "playlists", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "introduction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "creator_id"
    t.string "code"
    t.string "cypher"
  end

  create_table "playlists_songs", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "playlist_id", null: false
    t.bigint "song_id", null: false
    t.index ["playlist_id"], name: "index_playlists_songs_on_playlist_id"
    t.index ["song_id"], name: "index_playlists_songs_on_song_id"
  end

  create_table "playlists_users", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "playlist_id", null: false
    t.bigint "user_id", null: false
    t.index ["playlist_id"], name: "index_playlists_users_on_playlist_id"
    t.index ["user_id"], name: "index_playlists_users_on_user_id"
  end

  create_table "producer_copies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.float "share"
    t.bigint "song_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "agreement_number", comment: "权利对应协议编号"
    t.date "begin_date", comment: "开始时间"
    t.date "end_date", comment: "结束时间"
    t.string "district"
    t.index ["song_id"], name: "index_producer_copies_on_song_id"
  end

  create_table "recording_copies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.float "share"
    t.date "begin_date"
    t.date "end_date"
    t.string "district"
    t.string "sp"
    t.bigint "song_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "agreement_number", comment: "权利对应协议编号"
    t.string "rights_type"
    t.string "scope_business"
    t.string "authorization"
    t.index ["song_id"], name: "index_recording_copies_on_song_id"
  end

  create_table "songs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", comment: "歌曲名称"
    t.text "lyrics", comment: "歌词"
    t.date "release_date", comment: "发行日期"
    t.integer "genre", comment: "流派"
    t.string "grouping", comment: "分类"
    t.string "composers", comment: "曲作者"
    t.string "lyricists", comment: "词作者"
    t.string "audio_file", comment: "保存文件"
    t.string "ISRC"
    t.string "duration", comment: "长时"
    t.string "ownership", comment: "所属关系"
    t.datetime "created_at", null: false, comment: "创建时间"
    t.datetime "updated_at", null: false, comment: "更新时间"
    t.string "record_company", comment: "唱片公司"
    t.string "publisher", comment: "发行公司"
    t.string "library_name", comment: "曲库名称"
    t.string "language", comment: "语种"
    t.string "producer", comment: "制作人"
    t.string "recording_room", comment: "录音工作室"
    t.string "mixer", comment: "录音师"
    t.string "designer", comment: "设计"
    t.string "ar", comment: "艺人与制作部"
    t.string "UPC", comment: "UPC"
    t.string "arranger", comment: "编曲者"
    t.integer "own_lyric_copies", comment: "是否有词版权"
    t.integer "own_melody_copies", comment: "是否有曲版权"
    t.integer "own_producer_copies", comment: "是否有表演者版权"
    t.integer "own_recording_copies", comment: "是否有录音版权"
    t.string "business", comment: "商业范围"
    t.integer "classification", limit: 1, comment: "歌曲分类 1 正常 2 DEMO"
    t.string "lyricist_cert"
    t.string "composer_cert"
    t.string "performer_cert"
    t.string "producer_cert"
    t.string "licence"
    t.index ["classification"], name: "index_songs_on_classification"
    t.index ["composers"], name: "index_songs_on_composers"
    t.index ["genre"], name: "index_songs_on_genre"
    t.index ["lyricists"], name: "index_songs_on_lyricists"
    t.index ["own_lyric_copies"], name: "index_songs_on_own_lyric_copies"
    t.index ["own_melody_copies"], name: "index_songs_on_own_melody_copies"
    t.index ["own_producer_copies"], name: "index_songs_on_own_producer_copies"
    t.index ["own_recording_copies"], name: "index_songs_on_own_recording_copies"
    t.index ["ownership"], name: "index_songs_on_ownership"
    t.index ["title"], name: "index_songs_on_title"
  end

  create_table "taggings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", collation: "utf8_bin"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "videos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "version", comment: "版本号"
    t.string "grouping", comment: "类别"
    t.string "copyright", comment: "著作权比例"
    t.string "producer", comment: "制片人"
    t.date "release_date", comment: "发行日期"
    t.date "recording_date", comment: "录制日期"
    t.string "duration", comment: "时长"
    t.string "district", comment: "地区"
    t.string "definition", comment: "清晰度"
    t.string "copyright_company", comment: "版权公司"
    t.string "origin_copyright", comment: "原始版权方"
    t.string "ISRC"
    t.string "priority", comment: "是否重点"
    t.string "media_file", comment: "上传文件"
    t.bigint "song_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["song_id"], name: "index_videos_on_song_id"
  end

  add_foreign_key "lyric_copies", "songs"
  add_foreign_key "melody_copies", "songs"
  add_foreign_key "other_infos", "songs"
  add_foreign_key "producer_copies", "songs"
  add_foreign_key "recording_copies", "songs"
end
