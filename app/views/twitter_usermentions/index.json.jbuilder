json.array! @usermentions do |mention|
  # binding.pry
  json.screen_name mention.user.screen_name
  json.klout_score mention.user_klout_score
  json.text mention.text
  json.created_at mention.created_at
end
