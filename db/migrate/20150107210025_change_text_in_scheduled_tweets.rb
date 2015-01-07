class ChangeTextInScheduledTweets < ActiveRecord::Migration
  def change
    change_column :scheduled_tweets, :text, :text
  end
end
