class Playlist < ApplicationRecord

    attr_accessor :shared_field

    # validates
    validates :name, presence: true

    # association
    has_many :playlist_assignments
    
    belongs_to :creator, class_name: "User", foreign_key: "creator_id"

    has_and_belongs_to_many :users, join_table: :playlists_users

    before_create :generate_code

    def songs
       self.playlist_assignments.where("playable_type = 'Song'").all.map{|pl| Song.find_by(:id=>pl.playable_id)}
    end


    def demos
        self.playlist_assignments.where("playable_type = 'Demo'").all.map{|pl| Demo.find_by(:id=>pl.playable_id)}
    end

    private
    def generate_code
        self.code = /[A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9]/.random_example()
        self.cypher = /[A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9]/.random_example()
        self.allow_download = 1
        self.has_password = 1
    end
end
