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
    tweet.user
  end

  def created_at
    tweet.created_at
  end

  def location_data
      Faraday.get('https://maps.googleapis.com/maps/api/geocode/json?address=' + tweet.user.location + '&key=' + 'AIzaSyATXzRGTK2cxm9jCDcBGwRSJPbMgByqrAc')
    rescue TypeError
      nil
  end

  def parsed_location_data
    JSON.parse(location_data.body) if location_data
  end

  def latitude_from_profile
    parsed_location_data["results"][0]["geometry"]["location"]["lat"] + rand if parsed_location_data
  end

  def longitude_from_profile
    parsed_location_data["results"][0]["geometry"]["location"]["lng"] if parsed_location_data
  end

  def latitude_from_tweet
    tweet.place.bounding_box.coordinates[0][0][1]
  end

  def longitude_from_tweet
    tweet.place.bounding_box.coordinates[0][0][0]
  end

  def user_klout_score
    @klout ||=  begin
                  Klout::TwUser.new(user.id).score.score.to_i
                rescue JSON::ParserError, Klout::NotFound => ex
                  Rails.logger.error("oops klout blew up, here's the info: #{ex.message}")
                  "Oops can't get klout for this user"
                end
  end



end
