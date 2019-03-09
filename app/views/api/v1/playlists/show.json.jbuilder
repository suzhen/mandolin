json.partial! "api_v1_playlist", api_v1_playlist: @playlist
# json.songs @playlist.songs do |song|
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