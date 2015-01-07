RSpec.describe TwitterTimelineController, type: :controller do
  render_views

  let(:user) {create(:user)}

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return user
    allow_any_instance_of(Tweet).to receive(:user_klout_score).and_return 1

    VCR.insert_cassette("user")
  end

  describe 'index' do
    it 'returns an array of tweets' do
      get :index, format: :json

      expect(response.status).to eq 200
      expect(parsed_json_response_body.last).not_to be_empty
      expect(parsed_json_response_body.last['text']).to eq(last_tweet_text)
    end
  end

  describe 'create' do

  end
  
  private

    def last_tweet_text
      "Why it's harder than ever to unplug from our devices <a href=\"http://t.co/aa0q0Jj0QQ\" rel=\"nofollow\" target=\"_blank\">http://t.co/aa0q0Jj0QQ</a>"
    end
end
