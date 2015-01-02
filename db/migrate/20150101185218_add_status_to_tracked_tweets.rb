class AddStatusToTrackedTweets < ActiveRecord::Migration
  def change
    add_column :tracked_tweets, :status, :string, default: "unresolved", null: false
  end
end
