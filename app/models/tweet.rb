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
    unless tweet.user.location.is_a? Twitter::NullObject
      Faraday.get('https://maps.googleapis.com/maps/api/geocode/json?address=' + tweet.user.location + '&key=' + 'AIzaSyBIjVwl0qhgGMl8PI4AQi6zdn-_SzLCJBE')
    end
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
    @klout ||= KloutScore.new(user.id).fetch_score
  end

end
