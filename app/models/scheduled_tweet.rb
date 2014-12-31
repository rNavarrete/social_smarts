class ScheduledTweet < ActiveRecord::Base

  # def to_datetime
  #   Time.zone.parse(self.time)
  # end

  def to_datetime
    date_time_data = self.time
    time_data = date_time_data.split("/")[0]
    date_data = date_time_data.split("/")[1]
    time_data_expanded = time_data.split(" ")
    date_data_expanded = date_data.split(" ")
    date_time_expanded = date_data_expanded[0..3] + time_data_expanded[4..6]
    date_time_compressed = date_time_expanded.join(" ")
    Time.parse(date_time_compressed)
  end


end
