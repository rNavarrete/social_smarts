class User < ActiveRecord::Base
  has_many :tracked_tweets, dependent: :destroy

  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first
    user ? user.update_auth_attrs(auth) : create_with_auth(auth)
  end

  def self.klout_score(twitter_uid)
    KloutScore.new(twitter_uid).fetch_score
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
  end

  def fetch_mentions
    Rails.cache.fetch("twitter_mentions_#{uid}", expires_in: 24.hours) do
      @mentions ||= client.mentions_timeline.map { |t| Tweet.new(t) }
    end
  end

  def fetch_followers
    Rails.cache.fetch("twitter_followers_#{uid}", expires_in: 24.hours) do
      @followers = client.followers
    end
  end

  def update_auth_attrs(auth)
    update_attributes(
      provider: auth.provider,
      uid: auth.uid,
      name: auth.info.name,
      oauth_token: auth.credentials.token,
      oauth_secret: auth.credentials.secret
    )
    self
  end

  def location
    Rails.cache.fetch("twitter_location_#{uid}", expires_in: 24.hours) do
      unless client.verify_credentials.location.instance_of? Twitter::NullObject
        [client.verify_credentials.location]
      else
        [nil]
      end
    end
  end

  private

    def self.create_with_auth(auth)
      create do |user|
        user.provider = auth.provider
        user.image = auth.info.image
        user.uid = auth.uid
        user.name = auth.info.name
        user.oauth_token = auth.credentials.token
        user.oauth_secret = auth.credentials.secret
      end
    end

end
