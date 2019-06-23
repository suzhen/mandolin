require 'digest'
class Video < ApplicationRecord
    # validates
    validates :version, presence: true

    belongs_to :song

    mount_uploader :media_file, MusicUploader

    def attachment_url
        return "" unless self.media_file.path.present?
        u = "/" + self.media_file.path
        etime =  DateTime.now.to_i + 600
        token = "polaris"
        sign = Digest::MD5.hexdigest("#{token}&#{etime.to_s}&#{u}")
        upt =  sign[12, 8] + etime.to_s
        self.media_file.url + "?_upt=#{upt}"
    end
end
