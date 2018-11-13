class Album < ApplicationRecord
    # validates
    validates :title, presence: true
    validates :ISBN, uniqueness: true

    # association
    has_and_belongs_to_many :songs, join_table: :albums_songs

    mount_uploader :artwork, ArtworkUploader
end
