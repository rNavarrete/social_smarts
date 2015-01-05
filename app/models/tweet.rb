class Tweet
  include Twitter::Autolink
  attr_reader :tweet

  def initialize(tweet)
    @tweet = tweet
  end

  def text
    auto_link(tweet.text, target_blank: true)
  end

  def user
    # binding.pry
    tweet.user
  end

  def created_at
    tweet.created_at
  end

  def user_klout_score
    @klout ||= KloutScore.new(user.id).score
  end

end
