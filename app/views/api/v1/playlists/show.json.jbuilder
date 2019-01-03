json.partial! "api_v1_playlist", api_v1_playlist: @playlist
json.songs @playlist.songs do |song|
    json.ID song.id
    json.title song.title
    json.album song.albums[0].title
    json.album_release_date song.albums[0].release_date
    json.coverimg "http://#{song.albums[0].artwork}" 
    json.artists song.artists.map(&:name)
    json.composers song.composers
    json.lyricists song.lyricists
    json.audioFile "http://#{song.audio_file}"
    json.ISNB song.albums[0].ISBN
    json.ISRC song.ISRC
    json.genre song.genre
    json.length song.duration
    json.lyric song.lyrics
    json.ownership song.ownership
    json.tags song.tags.map(&:name)
    json.publisher song.publisher
    json.language song.language
    json.producer song.producer
    json.recording_room song.recording_room
    json.mixer song.mixer
    json.designer song.designer
    json.AR song.ar
    json.UPC song.UPC
    json.arranger song.arranger
    json.publish_platform song.other_info.nil? ? "" : song.other_info.publish_platform
    json.priority song.other_info.nil? ? "" : song.other_info.priority
    json.remark song.other_info.nil? ? "" : song.other_info.remark
    json.copyrights do
        if song.producer_copy
            json.artist do
                json.name song.producer_copy.name
                json.disctrict song.producer_copy.disctrict
                json.startDate song.producer_copy.begin_date
                json.endDate song.producer_copy.end_date
                json.share song.producer_copy.share ? "#{song.producer_copy.share*100}%" : 0
                json.agreement_number song.producer_copy.agreement_number
            end
        end
        if song.lyric_copy
            json.lyric do
                json.name song.lyric_copy.name
                json.disctrict song.lyric_copy.disctrict
                json.startDate song.lyric_copy.begin_date
                json.endDate song.lyric_copy.end_date
                json.share song.lyric_copy.share ? "#{song.lyric_copy.share*100}%" : 0
                json.agreement_number song.lyric_copy.agreement_number
            end
        end
        if song.melody_copy
            json.music do
                json.name song.melody_copy.name
                json.disctrict song.melody_copy.disctrict
                json.startDate song.melody_copy.begin_date
                json.endDate song.melody_copy.end_date
                json.share song.melody_copy.share ? "#{song.melody_copy.share*100}%" : 0
                json.agreement_number song.melody_copy.agreement_number
            end
        end
        if song.recording_copy
            json.recording do
                json.name song.recording_copy.name
                json.disctrict song.recording_copy.disctrict
                json.startDate song.recording_copy.begin_date
                json.endDate song.recording_copy.end_date
                json.share song.recording_copy.share ? "#{song.recording_copy.share*100}%" : 0
                json.agreement_number song.recording_copy.agreement_number
            end
        end
    end
end