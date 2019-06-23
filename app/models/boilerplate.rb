require 'digest'
class Boilerplate < ApplicationRecord
    # validates
    validates :name, presence: true

    mount_uploader :download, PdfDocUploader

    def attachment_url
        return "" unless self.download.path.present?
        u = "/" + self.download.path
        etime =  DateTime.now.to_i + 600
        token = "polaris"
        sign = Digest::MD5.hexdigest("#{token}&#{etime.to_s}&#{u}")
        upt =  sign[12, 8] + etime.to_s
        self.download.url + "?_upt=#{upt}"
    end

end
