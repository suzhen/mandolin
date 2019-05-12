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

    mount_uploader :attachment_pdf, PdfUploader
    mount_uploader :attachment_doc, DocUploader

    def encode_url(path)
        u = "/" + path
        etime =  DateTime.now.to_i + 900
        token = "polaris"
        sign = Digest::MD5.hexdigest("#{token}&#{etime.to_s}&#{u}")
        upt =  sign[12, 8] + etime.to_s
        "?_upt=#{upt}"
    end
        

    def attachment_url(type)
        if type == "PDF"
            return self.attachment_pdf.path.present? ? self.attachment_pdf.url + self.encode_url(self.attachment_pdf.path) : ""
        end
        if type == "DOC"
            return self.attachment_doc.path.present? ? self.attachment_doc.url + self.encode_url(self.attachment_doc.path) : ""
        end
        return ""
    end
end
