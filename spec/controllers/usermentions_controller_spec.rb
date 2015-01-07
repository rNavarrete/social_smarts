RSpec.describe TwitterUsermentionsController, type: :controller do
  render_views

  let(:user) {create(:user)}

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return user
    allow_any_instance_of(Tweet).to receive(:user_klout_score).and_return 1
  end

  describe 'index' do
    it 'returns an array of user mentions' do
      VCR.use_cassette("usermentions") do
        get :index, format: :json
      end

      expect(response.status).to eq 200
      expect(parsed_json_response_body.last).not_to be_empty
      expect(parsed_json_response_body.last['text']).to eq(last_user_mention)
    end
  end

  private

  def last_user_mention
    "@<a class=\"tweet-url username\" href=\"https://twitter.com/social_smarts\" rel=\"nofollow\" target=\"_blank\">social_smarts</a> Please  like and subscribe !! Very funny Bloopers: <a href=\"http://t.co/6Dc2v500XC\" rel=\"nofollow\" target=\"_blank\">http://t.co/6Dc2v500XC</a>"
  end
end
