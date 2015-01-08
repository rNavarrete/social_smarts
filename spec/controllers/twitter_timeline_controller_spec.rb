describe TwitterTimelineController, type: :controller do
  render_views

  let(:user) {create(:user)}

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return user
    allow_any_instance_of(Tweet).to receive(:user_klout_score).and_return 1
  end

  describe 'index' do
    it 'returns an array of tweets' do
      VCR.use_cassette("tweets") do
        get :index, format: :json
      end

      expect(response.status).to eq 200
      expect(parsed_json_response_body.last['text']).to eq(last_tweet_text)
    end
  end

  describe 'create' do
    it "posts a tweet" do
      VCR.use_cassette("create_tweet") do
        post :create, tweet: 'Hello!', format: :json
      end
    end
  end

  private

    def last_tweet_text
      "Why it's harder than ever to unplug from our devices <a href=\"http://t.co/aa0q0Jj0QQ\" rel=\"nofollow\" target=\"_blank\">http://t.co/aa0q0Jj0QQ</a>"
    end
end
