require 'digest'
class Album < ApplicationRecord
    # validates
    validates :title, presence: true
    # validates :ISBN, uniqueness: true

    # association
    has_and_belongs_to_many :songs, join_table: :albums_songs
    # belongs_to :artist

    mount_uploader :artwork, ArtworkUploader

    def attachment_url
        return "" unless self.artwork.path.present?
        u = "/" + self.artwork.path
        etime =  DateTime.now.to_i + 600
        token = "polaris"
        sign = Digest::MD5.hexdigest("#{token}&#{etime.to_s}&#{u}")
        upt =  sign[12, 8] + etime.to_s
        self.artwork.url + "?_upt=#{upt}"
    end

end
