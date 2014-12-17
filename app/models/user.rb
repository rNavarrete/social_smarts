class User < ActiveRecord::Base

  # def self.find_or_create_by_auth(auth_data)
  #   user = User.where(provider: auth_data['provider'], uid: auth_data['uid']).first_or_create
  #   if user.name != auth_data["info"]["name"]
  #     user.name = auth_data["info"]["name"]
  #     user.save
  #   end
  #   user
  # end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_secret = auth.credentials.secret
      user.save!
    end
  end

  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.provider = auth.provider
  #     user.uid      = auth.uid
  #     user.name     = auth.info.name
  #     user.save
  #   end
  # end

  def tweet(tweet)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["twitter_consumer_key"]
      config.consumer_secret     = ENV["twitter_api_secret_key"]
      config.access_token        = oauth_token
      config.access_token_secret = oauth_secret
    end
    client.update(tweet)
  end

end
