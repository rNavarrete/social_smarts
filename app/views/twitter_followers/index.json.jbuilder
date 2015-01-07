json.array! @followers do |follower|
  json.screen_name follower.screen_name
  json.klout_score follower.klout_score
end
