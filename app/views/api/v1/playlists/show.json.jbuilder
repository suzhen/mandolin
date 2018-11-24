json.partial! "api_v1_playlist", api_v1_playlist: @playlist
json.songs @playlist.songs do |song|
    json.ID song.id
    json.title song.title
    json.album song.albums[0].title
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
    json.copyrights do
        if song.producer_copy
            json.artist do
                json.OP song.producer_copy.name
                json.share "#{song.producer_copy.share*100}%"
            end
        end
        if song.lyric_copy
            json.lyric do
                json.OP song.lyric_copy.op
                json.SP song.lyric_copy.sp
                json.disctrict song.lyric_copy.disctrict
                json.startDate song.lyric_copy.begin_date
                json.endDate song.lyric_copy.end_date
                json.share song.lyric_copy.share ? "#{song.lyric_copy.share*100}%" : 0
            end
        end
        if song.melody_copy
            json.music do
                json.OP song.melody_copy.op
                json.SP song.melody_copy.sp
                json.composers song.melody_copy.name
                json.startDate song.melody_copy.begin_date
                json.endDate song.melody_copy.end_date
                json.share song.melody_copy.share ? "#{song.melody_copy.share*100}%" : 0
            end
        end
        if song.recording_copy
            json.recording do
                json.SP song.recording_copy.sp
                json.disctrict song.recording_copy.disctrict
                json.startDate song.recording_copy.begin_date
                json.endDate song.recording_copy.end_date
                json.share song.recording_copy.share ? "#{song.recording_copy.share*100}%" : 0
            end
        end
    end
end