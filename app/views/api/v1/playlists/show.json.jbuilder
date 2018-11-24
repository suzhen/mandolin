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
end