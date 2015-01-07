require 'ostruct'

RSpec.describe Tweet do
  let(:tweet) { Tweet.new(OpenStruct.new(text: "a tweet",
                                         user: OpenStruct.new(screen_name: "lukeaiken", id: 6253282),
                                         created_at: "today")) }

  it "has text" do
    expect(tweet.text).to eq "a tweet"
  end

  it "has a user" do
    expect(tweet.user.screen_name).to eq "lukeaiken"
  end

  it "has a created_at" do
    expect(tweet.created_at).to eq "today"
  end

  it "gives the user's klout score" do
    VCR.use_cassette('klout') do
      expect(tweet.user_klout_score).to be_a Integer
    end
  end

  it "returns a message when klout score cannot be found" do
    tweet.user.id = ""
    VCR.use_cassette('klout_error') do
      expect(tweet.user_klout_score).to be_a String
    end
  end
end
