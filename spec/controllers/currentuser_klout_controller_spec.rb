describe CurrentuserKloutController, type: :controller do
  render_views

  let(:user) {create(:user)}

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return user
  end

  describe 'index' do
    it 'returns klout score' do
      VCR.use_cassette("currentuser_klout_score") do
        get :index, format: :json
      end

      expect(response.status).to eq 200
      expect(parsed_json_response_body['current_user_klout']).to be_present
      expect(parsed_json_response_body['current_user_klout']).to eq 17
    end
  end

end
