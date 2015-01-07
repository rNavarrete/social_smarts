class ChangeTextFormatInTrackedTweets < ActiveRecord::Migration
  def change
    change_column :tracked_tweets, :text, :text
  end
end
