require 'rails_helper'

RSpec.describe TwitterMentionsController, type: :controller do

  describe 'index' do
    let(:user) {create(:user)}

    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return user
      VCR.use_cassette("mentions") do
        get :index, format: :json
      end
    end

    it 'returns mentions text' do
      expected_response = JSON.parse(response.body)
      mentions = expected_response
      expect(response.status).to eq 200
      expect(mentions.last).not_to be_empty
      expect(mentions.last['tweet']['text']).to eq("@social_smarts Please  like and subscribe !! Very funny Bloopers: http://t.co/6Dc2v500XC")
    end

    it 'returns mentions as json' do
      json_response = response.body
      parsed_response  = JSON.parse(response.body)
      expect(json_response).to eq parsed_response.to_json
    end

  end

end
