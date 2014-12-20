RSpec.describe TwitterClientController, type: :controller do

  describe 'index' do
    let(:user) { User.create(:provider => 'twitter',
                             :uid => '41835955',
                             :name => 'Kavita',
                             :oauth_token => '41835955-p6Z4O0vbHbqLy76LZlXR5eiffFhokWxZX4LOU242a',
                             :oauth_secret => 'aeBYPeRivPKQZ1iYVuFOSc3rUYze2UMpqxvbcLA2FMybc') }

# => #<Twitter::REST::Client:0x007faea1b37b88 @consumer_key="eXl06RGtKNnEc8AYlMuKjpo66", @consumer_secret="mUWIbDVoYDbsWIzTbUyz3ZrA7uywZUYNPXp77xLv1f5ZdVQ5J8", @access_token="41835955-fzM6Wu3TkjVqbozwvh0WGf5mBeJp6yVC1eZuag0pq", @access_token_secret="LYj0IqVHXT94flonICFvfgMH7jROrW9XPFh9xW7H62lps">

    let(:expected_response) {
      {
        tweet: 'Hey how are you',
        tweet: 'Tweets #2'
      }
    }

    before do
      VCR.use_cassette("user") do
        @tweets = user.fetch_tweets
        @mentions = user.fetch_mentions
      end
    end

    it 'returns tweets as json' do
      get :index
      expect(response.status).to eq 200
      # binding.pry
      expect(JSON.parse(@tweets.to_json).first["tweet"]["text"]).to equal "hello"
    end

    it 'returns mentions as json' do
      get :index
      expect(response.status).to eq 200
      # binding.pry
      expect(JSON.parse(@mentions.to_json).first["tweet"]["text"]).to equal ""
    end

  end

  describe 'create' do

  end

end
