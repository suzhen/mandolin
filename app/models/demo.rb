require 'digest'
require "mp3info"
class Demo < ApplicationRecord
    # association
    has_many :demoreferences
    has_many :artists, through: :demoreferences do
        def related_type(type)
            where("related_type = ?", type)
        end
    end

    has_many :playlist_assignments, :as => :playable

    def fetch_info(artist)
        {"id": artist.id, "name": artist.name}
    end

    def hold_bies
        self.artists.related_type("HOLD").map{ |artist| self.fetch_info(artist) }
    end

    def build_hold_bies(artists)
        unless artists.empty?
            self.demoreferences.where("related_type = 'HOLD'").destroy_all()
        end
        artists.each do |artist|
            self.demoreferences.build(artist_id:artist, related_type:"HOLD")
        end
    end

    def cut_bies
        self.artists.related_type("CUT").map{ |artist| self.fetch_info(artist) }
    end

    def build_cut_bies(artists)
        unless artists.empty?
            self.demoreferences.where("related_type = 'CUT'").destroy_all()
        end
        artists.each do |artist|
            self.demoreferences.build(artist_id:artist, related_type:"CUT")
        end
    end

    def writers
        self.artists.related_type("WRITER").map{ |artist| self.fetch_info(artist) }
    end

    def build_writers(artists)
        unless artists.empty?
            self.demoreferences.where("related_type = 'WRITER'").destroy_all()
        end
        artists.each do |artist|
            self.demoreferences.build(artist_id:artist, related_type:"WRITER")
        end
    end

    def pitched_artists
        self.artists.related_type("PITCHED").map{ |artist| self.fetch_info(artist) }
    end

    def build_pitched_artists(artists)
        unless artists.empty?
            self.demoreferences.where("related_type = 'PITCHED'").destroy_all()
        end
        artists.each do |artist|
            self.demoreferences.build(artist_id:artist, related_type:"PITCHED")
        end
    end

    # validates
    validates :title, presence: true

    def genere_to_str
        return self.genre.present? ? Genre.find_by(:code=>self.genre).chinese_name : ""
    end

    mount_uploader :audio_file, MusicUploader

    acts_as_taggable 

    def attachment_url
        return "" unless self.audio_file.path.present?
        u = "/" + self.audio_file.path
        etime =  DateTime.now.to_i + 600
        token = "polaris"
        sign = Digest::MD5.hexdigest("#{token}&#{etime.to_s}&#{u}")
        upt =  sign[12, 8] + etime.to_s
        self.audio_file.url + "?_upt=#{upt}"
    end

    def fill_out_info_from_file(mp3_path)
        Mp3Info.open(mp3_path) do |mp3info|
            self.bpm = mp3info.bitrate
            self.title = mp3info.tag.title
            self.genres = Genre.find_chinese_or_english_name(mp3info.tag.genre_s)
        end
    end

end
