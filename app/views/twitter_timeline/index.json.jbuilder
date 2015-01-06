json.array! @tweets do |tweet|
  json.text tweet.text
  json.screen_name tweet.user.screen_name
  json.created_at tweet.created_at
  json.klout_score tweet.user_klout_score
end
