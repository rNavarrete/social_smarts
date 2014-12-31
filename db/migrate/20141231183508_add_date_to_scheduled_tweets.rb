class AddDateToScheduledTweets < ActiveRecord::Migration
  def change
    add_column :scheduled_tweets, :date, :string
  end
end
