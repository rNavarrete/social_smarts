class ScheduledTweet < ActiveRecord::Base

  # def to_datetime
  #   Time.zone.parse(self.time)
  # end

  def to_datetime
    time = self.time[10..-1]
    date = self.date[0..9]
    date_time = date + time
    Time.parse(date_time)

    # time_data_expanded = time_data.split(" ")
    # date_data_expanded = date_data.split(" ")
    # date_time_expanded = time_data_expanded[0..3] + date_data_expanded[4..6]
    # date_time_compressed = date_time_expanded.join(" ")
    # Time.parse(date_time_compressed)
  end


end
