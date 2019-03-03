require 'digest'
class Demo < ApplicationRecord
    # association
    has_many :demoreferences
    has_many :artists, through: :demoreferences do
        def related_type(type)
            where("related_type = ?", type)
        end
    end

    def fetch_info(artist)
        {"id": artist.id, "name": artist.name}
    end

    def hold_bies
        self.artists.related_type("HOLD").map{ |artist| self.fetch_info(artist) }
    end

    def build_hold_bies(artists)
        artists.each do |artist|
            self.demoreferences.build(artist_id:artist, related_type:"HOLD")
        end
    end

    def cut_bies
        self.artists.related_type("CUT").map{ |artist| self.fetch_info(artist) }
    end

    def build_cut_bies(artists)
        artists.each do |artist|
            self.demoreferences.build(artist_id:artist, related_type:"CUT")
        end
    end

    def writers
        self.artists.related_type("WRITER").map{ |artist| self.fetch_info(artist) }
    end

    def build_writers(artists)
        artists.each do |artist|
            self.demoreferences.build(artist_id:artist, related_type:"WRITER")
        end
    end

    def pitched_artists
        self.artists.related_type("PITCHED").map{ |artist| self.fetch_info(artist) }
    end

    def build_pitched_artists(artists)
        artists.each do |artist|
            self.demoreferences.build(artist_id:artist, related_type:"PITCHED")
        end
    end

    # validates
    validates :title, presence: true

    def genere_to_str
        return self.genres.present? ? self.genres.split(",").map{|g| Genre.find_by(:code=>g).chinese_name } : ""
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

end
