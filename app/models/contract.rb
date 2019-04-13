class Contract < ApplicationRecord
    # association
    has_many :contract_assignments

    def songs
        self.contract_assignments.where("contractable_type = 'Song'").all.map{|ly| Song.find_by(:id=>ly.contractable_id)}
    end
 
    def demos
        self.contract_assignments.where("contractable_type = 'Demo'").all.map{|ly| Demo.find_by(:id=>ly.contractable_id)}
    end

    def libraries
        self.contract_assignments.where("contractable_type = 'Library'").all.map{|ly| Library.find_by(:id=>ly.contractable_id)}
    end
end
