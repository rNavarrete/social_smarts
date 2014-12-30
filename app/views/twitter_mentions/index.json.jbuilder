json.array! @mentions do |mention|
  # binding.pry
  json.text mention.text
  json.screen_name mention.user.screen_name
  json.screen_name mention.user_klout_score
  json.place mention.tweet.place
  json.created_at mention.created_at
end
