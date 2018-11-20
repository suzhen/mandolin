json.partial! "api_v1_song", api_v1_song: @song
json.tags @song.tags do |tag|
    json.tagId tag.id
    json.tagName tag.name
    json.tagCount tag.taggings_count
end