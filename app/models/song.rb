class Song < ApplicationRecord
    # validates
    validates :title, presence: true
    after_initialize :ensure_copies

    # association
    has_and_belongs_to_many :albums, join_table: :albums_songs
    has_and_belongs_to_many :artists, join_table: :artist_songs
    has_and_belongs_to_many :playlists, join_table: :playlists_songs

    has_many :melody_copies, :dependent => :destroy
    accepts_nested_attributes_for :melody_copies
    
    has_many :lyric_copies, :dependent => :destroy
    accepts_nested_attributes_for :lyric_copies
    
    has_many :producer_copies, :dependent => :destroy
    accepts_nested_attributes_for :producer_copies
    
    has_many :recording_copies, :dependent => :destroy
    accepts_nested_attributes_for :recording_copies

    has_one :other_info, :dependent => :destroy
    accepts_nested_attributes_for :other_info


    def ensure_copies
        return unless new_record?
        self.melody_copies << MelodyCopy.new
        self.lyric_copies << LyricCopy.new
        self.producer_copies << ProducerCopy.new
        self.recording_copies << RecordingCopy.new
        self.other_info ||= OtherInfo.new
    end

    mount_uploader :audio_file, MusicUploader

    acts_as_taggable 

end
