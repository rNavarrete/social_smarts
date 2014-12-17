TWITTER = Twitter::REST::Client.new do |config|            # ~> NameError: uninitialized constant Twitter
  config.consumer_key    = ENV["twitter_consumer_key"]
  config.consumer_secret = ENV["twitter_api_secret_key"]
  config.access_token        = ENV["twitter_access_token"]
  config.access_token_secret = ENV["twitter_access_secret"]
end



# ~> NameError
# ~> uninitialized constant Twitter
# ~>
# ~> /Users/Home/social_smarts/config/initializers/twitter.rb:1:in `<main>'
