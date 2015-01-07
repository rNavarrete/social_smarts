# binding.pry
json.array! @followers do |follower|
  json.screen_name follower.screen_name
  # json.klout_score User::klout_score
  json.created_at follower.created_at
end
