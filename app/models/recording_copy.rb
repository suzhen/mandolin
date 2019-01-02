class RecordingCopy < ApplicationRecord
     # validates
     # validates :name, presence: true
     # validates :song, absence: true
     
     # association
     belongs_to :song
end
