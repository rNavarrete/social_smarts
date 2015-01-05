# json.array! @tweets do |tweet|
#   # json.
#   json.text tweet.text
#   json.screen_name tweet.user.screen_name
#   json.created_at tweet.created_at
#   json.klout_score tweet.user_klout_score
# end

# json.cu_klout_score do
  # binding.pry
  json.cu_klout KloutScore.new(current_user.uid).score  
# end
