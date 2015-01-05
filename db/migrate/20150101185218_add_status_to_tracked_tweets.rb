class AddStatusToTrackedTweets < ActiveRecord::Migration
  def change
    add_column :tracked_tweets, :status, :string, default: "unresolved", null: false
    execute "ALTER TABLE tracked_tweets ADD CONSTRAINT status_options CHECK (status IN ('resolved', 'unresolved'))"
  end
end
