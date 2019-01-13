json.partial! "api_v1_song", api_v1_song: @song

json.ID @song.id
json.title @song.title
json.album @song.albums.present? ? @song.albums[0].title : ""
json.album_id @song.albums.present? ? @song.albums[0].id : ""
json.album_release_date @song.albums.present? ? @song.albums[0].release_date : "0000-00-00"
json.coverimg @song.albums.present? ? "http://#{@song.albums[0].artwork}" : "0000-00-00" 
json.ISBN @song.albums.present? ? @song.albums[0].ISBN : "0000-00-00"  
json.artists @song.artists.map(&:name)
json.artist_ids @song.artists.map(&:id)
json.composers @song.composers
json.lyricists @song.lyricists
json.audioFile "http://#{@song.audio_file}"
json.ISRC @song.ISRC
json.genre @song.genere_to_str
json.length @song.duration
json.lyric @song.lyrics
json.ownership @song.ownership
json.publisher @song.publisher
json.language @song.language
json.producer @song.producer
json.recording_room @song.recording_room
json.record_company @song.record_company
json.mixer @song.mixer
json.designer @song.designer
json.AR @song.ar
json.UPC @song.UPC
json.arranger @song.arranger
json.business @song.business
json.publish_platform @song.other_info.nil? ? "" : @song.other_info.publish_platform
json.priority @song.other_info.nil? ? "" : @song.other_info.priority
json.remark @song.other_info.nil? ? "" : @song.other_info.remark
json.copyrights do
    json.artist @song.producer_copies do |producer_copy| 
        json.name producer_copy.name
        json.district producer_copy.district
        json.startDate producer_copy.begin_date
        json.endDate producer_copy.end_date
        json.share producer_copy.share ? "#{producer_copy.share*100}%" : 0
        json.agreement_number producer_copy.agreement_number
    end
    json.lyric @song.lyric_copies do |lyric_copy| 
        json.name lyric_copy.name
        json.district lyric_copy.district
        json.startDate lyric_copy.begin_date
        json.endDate lyric_copy.end_date
        json.share lyric_copy.share ? "#{lyric_copy.share*100}%" : 0
        json.agreement_number lyric_copy.agreement_number
    end

    json.music @song.melody_copies do |melody_copy| 
        json.name melody_copy.name
        json.district melody_copy.district
        json.startDate melody_copy.begin_date
        json.endDate melody_copy.end_date
        json.share melody_copy.share ? "#{melody_copy.share*100}%" : 0
        json.agreement_number melody_copy.agreement_number
    end

    json.recording @song.recording_copies do |recording_copy| 
        json.name recording_copy.name
        json.district recording_copy.district
        json.startDate recording_copy.begin_date
        json.endDate recording_copy.end_date
        json.share recording_copy.share ? "#{recording_copy.share*100}%" : 0
        json.agreement_number recording_copy.agreement_number
    end
end
json.tags @song.tags do |tag|
    json.tagId tag.id
    json.tagName tag.name
    json.tagCount tag.taggings_count
end