json.partial! "api_v1_video", api_v1_video: @video
json.mediaFile @video.attachment_url.present? ? "http://#{@video.attachment_url}" : ""
