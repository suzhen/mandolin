class Playlist < ApplicationRecord
    # validates
    validates :name, presence: true

    # association
    has_and_belongs_to_many :songs, join_table: :playlists_songs
end
