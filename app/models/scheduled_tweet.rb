class ScheduledTweet < ActiveRecord::Base

  def to_datetime
    Time.zone.parse(self.time)
  end

end
