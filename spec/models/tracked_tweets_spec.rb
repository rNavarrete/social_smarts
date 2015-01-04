RSpec.describe TrackedTweet, :type => :model do
  let(:user) { create(:user) }
  let(:tracked_tweet) { create(:tracked_tweet, user: user) }

  it "belongs to a user" do
    expect(tracked_tweet.user).to eq user
  end

  it "has a status as either resolved or unresolved" do
    tracked_tweet.status = "resolved"
    expect(tracked_tweet).to be_valid
    tracked_tweet.status = "unresolved"
    expect(tracked_tweet).to be_valid
    tracked_tweet.status = ""
    expect(tracked_tweet).to_not be_valid
  end
end
