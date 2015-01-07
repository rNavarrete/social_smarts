RSpec.describe TwitterMentionsController, type: :controller do
  let(:user) {create(:user)}

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return user
  end

  describe 'index' do
    it 'returns an array of mentions' do
      VCR.use_cassette("mentions") do
        get :index, format: :json
      end

      expect(response.status).to eq 200
      expect(parsed_json_response_body.last['tweet']['text']).to eq(last_tweet_text)
    end
  end

  private

    def last_tweet_text
      "@social_smarts Please  like and subscribe !! Very funny Bloopers: http://t.co/6Dc2v500XC"
    end

end
