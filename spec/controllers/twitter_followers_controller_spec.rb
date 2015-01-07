RSpec.describe TwitterFollowersController, type: :controller do
  render_views

  let(:user) {create(:user)}

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return user
    # allow_any_instance_of(Tweet).to receive(:user_klout_score).and_return 1
  end

  describe 'index' do
    it 'returns an array of followers' do
      VCR.use_cassette("followers") do
        get :index, format: :json
      end

      expect(response.status).to eq 200
      expect(parsed_json_response_body.last).not_to be_empty
      expect(parsed_json_response_body.last['screen_name']).to eq(last_follower_screen_name)
    end
  end

  private

  def last_follower_screen_name
    "kavita_s"
  end
end
