class User < ActiveRecord::Base
  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first
    user ? user.update_auth_attrs(auth) : create do |user|
                                            user.provider = auth.provider
                                            user.uid = auth.uid
                                            user.name = auth.info.name
                                            user.oauth_token = auth.credentials.token
                                            user.oauth_secret = auth.credentials.secret
                                            user.save!
                                          end
  end

  def client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["twitter_consumer_key"]
      config.consumer_secret     = ENV["twitter_api_secret_key"]
      config.access_token        = oauth_token
      config.access_token_secret = oauth_secret
    end
  end

  def tweet(tweet)
    client.update(tweet)
  end

  def fetch_tweets
    @tweets ||= client.home_timeline.map {|t| Tweet.new(t) }
    # binding.pry
  end

  def fetch_mentions
    @mentions ||= client.mentions_timeline.map { |t| Tweet.new(t) }
  end

  def update_auth_attrs(auth)
    provider = auth.provider
    uid = auth.uid
    name = auth.info.name
    oauth_token = auth.credentials.token
    oauth_secret = auth.credentials.secret
    save!
    self
  end
end
