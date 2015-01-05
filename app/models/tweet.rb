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

  # def current_user_klout_score
  #   @klout ||=  begin
  #                 Klout::TwUser.new(current_user.uid).score.score.to_i
  #               rescue StandardError => ex
  #                 Rails.logger.error("oops klout blew up, here's the info: #{ex.message}")
  #                 "Oops can't get klout for this user"
  #               end
  # end
end
