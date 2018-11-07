require 'rails_helper'

RSpec.describe Song, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  s = Song.new(:title=>"念奴娇", :ISRC=>"ssss")

  File.open(Rails.root.join('mock/吴克群-对不起.mp3')) do |f|
    s.audio_file = f
  end

  # s.tags = ["awesome", "slick"]
  # puts s.file.url
  # s.file = s.entity.current_path
  s.tag_list.add("awesome")
  s.tag_list.add("awesome")
  s.save!

  puts s.tag_list
  puts s.audio_file.url


  puts s.audio_file.current_path
  # puts(s)
end
