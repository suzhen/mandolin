class LibraryAssignment < ApplicationRecord
    belongs_to :libraryable, :polymorphic=>true
    belongs_to :library
end
