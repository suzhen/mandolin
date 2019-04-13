class Library < ApplicationRecord
    # validates
    validates :name, presence: true
    # association
    has_many :library_assignments

    def songs
        self.library_assignments.where("libraryable_type = 'Song'").all.map{|ly| Song.find_by(:id=>ly.libraryable_id)}
    end
 
    def demos
        self.library_assignments.where("libraryable_type = 'Demo'").all.map{|ly| Demo.find_by(:id=>ly.libraryable_id)}
    end
end
