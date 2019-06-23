require 'digest'
require "mp3info"
class Song < ApplicationRecord
    # validates
    validates :title, presence: true
    after_initialize :ensure_attributes
    before_save :ensure_copies

    # association
    has_and_belongs_to_many :albums, join_table: :albums_songs
    has_and_belongs_to_many :artists, join_table: :artist_songs
    has_many :videos
    has_many :playlist_assignments, :as => :playable
    has_many :library_assignments, :as => :libraryable
    has_many :contract_assignments, :as => :contractable

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
    mount_uploader :composer_cert, PdfUploader
    mount_uploader :lyricist_cert, PdfUploader
    mount_uploader :performer_cert, PdfUploader
    mount_uploader :producer_cert, PdfUploader
    mount_uploader :licence, PdfUploader

    acts_as_taggable 

    def encode_url(path)
        u = "/" + path
        etime =  DateTime.now.to_i + 900
        token = "polaris"
        sign = Digest::MD5.hexdigest("#{token}&#{etime.to_s}&#{u}")
        upt =  sign[12, 8] + etime.to_s
        "?_upt=#{upt}"
    end
        

    def attachment_url(type)
        if type == "AUDIOFILE"
            return self.audio_file.path.present? ? self.audio_file.url + self.encode_url(self.audio_file.path) : ""
        end
        if type == "LYRICISTCERT"
            return self.lyricist_cert.path.present? ? self.lyricist_cert.url + self.encode_url(self.lyricist_cert.path) : ""
        end
        if type == "COMPOSERCERT"
            return self.composer_cert.path.present? ? self.composer_cert.url + self.encode_url(self.composer_cert.path) : ""
        end
        if type == "PERFORMERCERT"
            return self.performer_cert.path.present? ? self.performer_cert.url + self.encode_url(self.performer_cert.path) : ""
        end
        if type == "PRODUCERCERT"
            return self.producer_cert.path.present? ? self.producer_cert.url + self.encode_url(self.producer_cert.path) : ""
        end
        if type == "LICENCE"
            return self.licence.path.present? ? self.licence.url + self.encode_url(self.licence.path) : ""
        end
        return ""
    end


    def fill_out_info_from_file(mp3_path)
        # Mp3Info.open(mp3_path) do |mp3info|
        #     puts mp3info
        #     puts mp3info.tag.title   
        #     puts mp3info.tag.artist   
        #     puts mp3info.tag.album
        #     puts mp3info.tag.tracknum
        # end
    end


end
