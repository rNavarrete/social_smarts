RSpec.describe TwitterLocationController, type: :controller do
  let(:user) { create(:user) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return user
  end

  describe 'index' do
    it "returns tweet's location" do
      VCR.use_cassette("location") do
        get :index, format: :json
      end

      expect(response.status).to eq 200
      expect(parsed_json_response_body[0]).to eq("Pittsburgh")
    end
  end

end
