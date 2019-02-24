require 'digest'
class Demo < ApplicationRecord
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
