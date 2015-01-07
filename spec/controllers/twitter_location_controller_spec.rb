RSpec.describe TwitterLocationController, type: :controller do
  let(:user) { create(:user) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return user
    VCR.insert_cassette("location")
  end

  describe 'index' do
    it "returns tweet's location" do
      get :index, format: :json

      expect(response.status).to eq 200
      expect(parsed_json_response_body[0]).to eq("Pittsburgh")
    end
  end

end
