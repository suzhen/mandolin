class PlaylistAssignment < ApplicationRecord
    belongs_to :playable, :polymorphic=>true
    belongs_to :playlist
end