class KloutScore
  attr_reader :twitter_uid
  def initialize(twitter_uid)
    @twitter_uid = twitter_uid
  end

  def score
    @score ||= begin
                 Klout::TwUser.new(twitter_uid).score.score.to_i
               rescue JSON::ParserError => ex
                 Rails.logger.error("oops klout blew up, here's the info: #{ex.message}")
                 "Oops can't get klout for this user"
               end
  end
end
