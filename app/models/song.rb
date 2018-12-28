class Song < ApplicationRecord
    # validates
    validates :title, presence: true
    # validates :ISRC, uniqueness: true

    # association
    has_and_belongs_to_many :albums, join_table: :albums_songs
    has_and_belongs_to_many :artists, join_table: :artist_songs
    has_and_belongs_to_many :playlists, join_table: :playlists_songs

    has_one :melody_copy, :dependent => :destroy
    accepts_nested_attributes_for :melody_copy
    
    has_one :lyric_copy, :dependent => :destroy
    accepts_nested_attributes_for :lyric_copy
    
    has_one :producer_copy, :dependent => :destroy
    accepts_nested_attributes_for :producer_copy
    
    has_one :recording_copy, :dependent => :destroy
    accepts_nested_attributes_for :recording_copy

    has_one :other_info, :dependent => :destroy
    accepts_nested_attributes_for :other_info

    mount_uploader :audio_file, MusicUploader

    acts_as_taggable 

end
