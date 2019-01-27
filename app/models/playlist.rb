class Playlist < ApplicationRecord
    # validates
    validates :name, presence: true

    # association
    has_and_belongs_to_many :songs, join_table: :playlists_songs
    
    belongs_to :creator, class_name: "User", foreign_key: "creator_id"

    has_and_belongs_to_many :users, join_table: :playlists_users

    before_create :generate_code

    private
    def generate_code
        self.code = /[A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9]/.random_example()
        self.cypher = /[A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9]/.random_example()
    end
end
