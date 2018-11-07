class Song < ApplicationRecord
    # validates
    validates :title, presence: true
    # validates :ISRC, uniqueness: true

    # association
    has_and_belongs_to_many :albums, join_table: :albums_songs
    has_and_belongs_to_many :artists, join_table: :artist_songs

    has_one :melody_copy
    has_one :lyric_copy
    has_one :producer_copy
    has_one :recording_copy

    mount_uploader :audio_file, MusicUploader

    acts_as_taggable 
end
