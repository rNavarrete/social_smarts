class CreateScheduledTweets < ActiveRecord::Migration
  def change
    create_table :scheduled_tweets do |t|
      t.integer :user_id
      t.string :text
      t.string :time

      t.timestamps
    end
  end
end
