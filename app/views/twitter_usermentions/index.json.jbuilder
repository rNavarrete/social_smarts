json.array! @usermentions do |mention|
  json.screen_name mention.user.screen_name
  json.klout_score mention.user_klout_score
  json.text mention.text
  json.created_at mention.created_at
  json.tweet_data mention
  json.latitude_from_profile mention.latitude_from_profile
  json.longitude_from_profile mention.longitude_from_profile
  json.image mention.user.profile_image_url.to_s
end
