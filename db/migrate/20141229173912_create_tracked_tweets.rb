class CreateTrackedTweets < ActiveRecord::Migration
  def change
    create_table :tracked_tweets do |t|
      t.string :text
      t.string :screen_name
      t.references :user
      t.string :created_at
    end
  end
end
