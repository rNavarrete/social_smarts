class TrackedTweet < ActiveRecord::Base
  belongs_to :user

  validates :status, inclusion: { in: %w(resolved unresolved) }
end
