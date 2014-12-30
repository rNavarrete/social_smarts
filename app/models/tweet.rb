class Tweet
  attr_reader :tweet
  def initialize(tweet)
    @tweet = tweet
  end

  def text
    tweet.text
  end

  def user
    tweet.user
  end

  def created_at
    tweet.created_at
  end

  def user_klout_score
    @klout ||=  begin
                  Klout::TwUser.new(user.id).score.score.to_i
                rescue StandardError => ex
                  Rails.logger.error("oops klout blew up, here's the info: #{ex.message}")
                  "Oops can't get klout for this user"
                end
  end
end
