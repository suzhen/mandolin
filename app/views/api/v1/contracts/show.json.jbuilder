json.partial! "api_v1_contract", api_v1_contract: @contract
json.ID @contract.id
json.name @contract.name
json.time_limit @contract.time_limit
json.expire_date @contract.expire_date.present? ? @contract.expire_date.strftime("%Y-%m-%d") : ""
json.auth_duration @contract.auth_duration.present? ? @contract.auth_duration.strftime("%Y-%m-%d") : ""
json.auth_right @contract.auth_right
json.song_ids @contract.songs.map(&:id)
json.song_names @contract.songs.map(&:title)
json.demo_ids @contract.demos.map(&:id)
json.library_ids @contract.libraries.map(&:id)
json.library_names @contract.libraries.map(&:name)
json.attachment_pdf @contract.attachment_url("PDF").present? ? "http://#{@contract.attachment_url("PDF")}" : ""
json.attachment_doc @contract.attachment_url("DOC").present? ? "http://#{@contract.attachment_url("DOC")}" : ""
# json.songs @contract.songs do |song|
#     json.type "song"
#     json.ID song.id
#     json.title song.title
#     json.audioFile "http://#{song.attachment_url}"
#     json.artists song.artists.map(&:name)
#     json.coverimg song.albums.present? ? "http://#{song.albums[0].artwork}" : "" 
#     json.copyrights do
#         json.artist song.producer_copies do |producer_copy| 
#             json.name producer_copy.name
#             json.district producer_copy.district
#             json.startDate producer_copy.begin_date
#             json.endDate producer_copy.end_date
#             json.share producer_copy.share ? "#{producer_copy.share*100}%" : 0
#             json.agreement_number producer_copy.agreement_number
#         end
#         json.lyric song.lyric_copies do |lyric_copy| 
#             json.name lyric_copy.name
#             json.district lyric_copy.district
#             json.startDate lyric_copy.begin_date
#             json.endDate lyric_copy.end_date
#             json.share lyric_copy.share ? "#{lyric_copy.share*100}%" : 0
#             json.agreement_number lyric_copy.agreement_number
#         end
    
#         json.music song.melody_copies do |melody_copy| 
#             json.name melody_copy.name
#             json.district melody_copy.district
#             json.startDate melody_copy.begin_date
#             json.endDate melody_copy.end_date
#             json.share melody_copy.share ? "#{melody_copy.share*100}%" : 0
#             json.agreement_number melody_copy.agreement_number
#         end
    
#         json.recording song.recording_copies do |recording_copy| 
#             json.name recording_copy.name
#             json.district recording_copy.district
#             json.startDate recording_copy.begin_date
#             json.endDate recording_copy.end_date
#             json.share recording_copy.share ? "#{recording_copy.share*100}%" : 0
#             json.agreement_number recording_copy.agreement_number
#         end
#     end
# end
# json.demos @contract.demos do |demo|
#     json.type "demo"
#     json.title demo.title
#     json.genre demo.genere_to_str
#     json.source demo.source 
#     json.writers demo.writers 
#     json.year demo.year
#     json.mfd demo.mfd 
#     json.notes demo.notes 
#     json.bpm demo.bpm
#     json.pitched_artists demo.pitched_artists 
#     json.hold_by demo.hold_bies
#     json.cut_by demo.cut_bies
#     json.audioFile demo.attachment_url.present? ? "http://#{demo.attachment_url}" : ""
# end
# json.libraries @contract.libraries do |library|
#     json.name library.name
# end