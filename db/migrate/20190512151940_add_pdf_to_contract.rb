class AddPdfToContract < ActiveRecord::Migration[5.2]
  def change
    add_column :contracts, :attachment_pdf, :string
    add_column :contracts, :attachment_doc, :string
  end
end
