class TwitterClient
  attr_accessor :twitter_client

  def initialize(external_client = TWITTER)
    @twitter_client = external_client
  end

  def self.fetch_tweets(username)
    twitter_client.user_timeline(username)
  end
end
