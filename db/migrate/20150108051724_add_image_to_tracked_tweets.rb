class AddImageToTrackedTweets < ActiveRecord::Migration
  def change
    add_column :tracked_tweets, :image, :string
  end
end
