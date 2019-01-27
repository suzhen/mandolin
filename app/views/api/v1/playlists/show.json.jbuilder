json.partial! "api_v1_playlist", api_v1_playlist: @playlist
json.songs @playlist.songs do |song|
    json.ID song.id
    json.title song.title
    json.audioFile "http://#{song.attachment_url}"
    json.artists song.artists.map(&:name)
end