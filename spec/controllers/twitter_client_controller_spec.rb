require 'rails_helper'

RSpec.describe TwitterClientController, type: :controller do

  describe 'index' do
    let(:user) { User.create(:provider => 'twitter',
                             :uid => '2935410678',
                             :name => 'Social Smarts',
                             :oauth_token => '2935410678-GpBDrY8zuSDIXhX9TBOEZCFroNvmZzpgGELOecm',
                             :oauth_secret => 'un2eJJAWAIJoHrzuHN9B3oJf9SidobAzFKL6KlSywmVvF') }

    before do
      VCR.use_cassette("user") do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return user
        get :index, format: :json
      end
    end

    it 'returns tweets text' do
      expected_response = JSON.parse(response.body)
      tweets = expected_response.first
      expect(response.status).to eq 200
      expect(tweets.last).not_to be_empty
      expect(tweets.last['tweet']['text']).to eq("Why it's harder than ever to unplug from our devices http://t.co/aa0q0Jj0QQ")
    end

    it 'returns mentions text' do
      expected_response = JSON.parse(response.body)
      mentions = expected_response.last
      expect(response.status).to eq 200
      expect(mentions.first['tweet']['text']).to eq("@social_smarts Hello world!")
    end

    it 'returns tweets and mentions as json' do
        json_response = response.body
        parsed_response  = JSON.parse(response.body)
        expect(json_response).to eq parsed_response.to_json
    end

  end

  describe 'create' do

  end

end
