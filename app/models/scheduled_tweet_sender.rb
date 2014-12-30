class ScheduledTweetSender

  def self.send_tweets
    ScheduledTweet.all.each do |tweet|
      if tweet.to_datetime < Time.zone.now
        user = User.find(tweet.user_id)
        user.client.update(tweet.text)
        tweet.delete
      end
    end
  end

end
