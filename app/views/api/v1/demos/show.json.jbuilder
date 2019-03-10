json.partial! "api_v1_demo", api_v1_demo: @demo

json.type "demo"
json.title @demo.title
json.genre @demo.genere_to_str
json.source @demo.source 
json.writers @demo.writers 
json.year @demo.year
json.mfd @demo.mfd 
json.notes @demo.notes 
json.bpm @demo.bpm
json.pitched_artists @demo.pitched_artists 
json.hold_by @demo.hold_bies
json.cut_by @demo.cut_bies
json.audioFile @demo.attachment_url.present? ? "http://#{@demo.attachment_url}" : ""

json.tags @demo.tags do |tag|
    json.tagId tag.id
    json.tagName tag.name
    json.tagCount tag.taggings_count
end