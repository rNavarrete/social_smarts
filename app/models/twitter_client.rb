class TwitterClient
  attr_accessor :twitter_client

  def initialize(external_client = TWITTER)
    @twitter_client = external_client
  end

  def fetch_tweets
    twitter_client.user_timeline
  end

  def fetch_mentions
    twitter_client.mentions_timeline
  end


end
