class Song < ApplicationRecord
    # validates
    validates :title, presence: true
    after_initialize :ensure_attributes
    before_save :ensure_copies

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


    def ensure_attributes
        return unless new_record?
        # self.melody_copies << MelodyCopy.new
        # self.lyric_copies << LyricCopy.new
        # self.producer_copies << ProducerCopy.new
        # self.recording_copies << RecordingCopy.new
        self.other_info ||= OtherInfo.new
    end

    def ensure_copies
        self.own_lyric_copies = self.lyric_copies.present? ? self.accumulate_share(self.lyric_copies.map(&:share)) : false
        self.own_melody_copies = self.melody_copies.present? ? self.accumulate_share(self.melody_copies.map(&:share)) : false
        self.own_producer_copies = self.producer_copies.present? ? self.accumulate_share(self.producer_copies.map(&:share)) : false
        self.own_recording_copies = self.recording_copies.present? ? self.accumulate_share(self.recording_copies.map(&:share)) : false
    end

    def accumulate_share shares
        return shares.map(&:to_f).reduce(:+) > 0
    end

    def genere_to_str
        return self.genre.present? ? Genre.find_by(:code=>self.genre).chinese_name : ""
    end

    mount_uploader :audio_file, MusicUploader

    acts_as_taggable 

end
