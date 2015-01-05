require 'rails_helper'

RSpec.describe TwitterTimelineController, type: :controller do
  render_views

  describe 'index' do
    let(:user) {create(:user)}

    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return user
      allow_any_instance_of(Tweet).to receive(:user_klout_score).and_return 1
      VCR.use_cassette("user") do
        get :index, format: :json
      end
    end

    it 'returns tweets text' do
      expected_response = JSON.parse(response.body)
      tweets = expected_response
      expect(response.status).to eq 200
      expect(tweets.last).not_to be_empty
      expect(tweets.last['text']).to eq("Why it's harder than ever to unplug from our devices <a href=\"http://t.co/aa0q0Jj0QQ\" rel=\"nofollow\" target=\"_blank\">http://t.co/aa0q0Jj0QQ</a>")
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
