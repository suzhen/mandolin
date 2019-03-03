class Artist < ApplicationRecord
    # validates
    validates :name, presence: true
    
    # association
    has_and_belongs_to_many :songs, join_table: :artist_songs
    has_many :albums

    has_many :demoreferences
    has_many :demo, through: :demoreferences

end
