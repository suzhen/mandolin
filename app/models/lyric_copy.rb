class LyricCopy < ApplicationRecord
    # validates
    validates :name, presence: true

    # association
    belongs_to :song
end
