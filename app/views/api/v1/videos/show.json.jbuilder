json.partial! "api_v1_video", api_v1_video: @video
json.mediaFile @video.attachment_url.present? ? "http://#{@video.attachment_url}" : ""
json.songs do
    json.id @video.song.id
    json.title @video.song.title
    json.language @video.song.language
    json.genre @video.song.genere_to_str
    json.ISRC @video.song.ISRC
    json.album @video.song.albums[0].title
    json.artist @video.song.artists.map(&:name)
    json.artist_ids @video.song.artists.map(&:id)
end