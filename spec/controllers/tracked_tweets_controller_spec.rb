RSpec.describe TrackedTweetsController do
  let(:user) { create(:user) }

  before do
    request.session[:user_id] = user.id
    2.times { create(:tracked_tweet, user: user) }
  end

  describe "GET index" do
    it "responds with a json array of tracked tweets" do
      get :index, format: :json
      expect(response.status).to eq 200
      parsed_body = JSON.parse(response.body)
      expect(parsed_body[0]["text"]).to eq "tweeting"
    end
  end

  describe "POST create" do
    it "responds with a created tracked tweet" do
      post :create, format: :json, text: "new tweet", 
                                   screen_name: "kavita", 
                                   created_at: "today", 
                                   klout_score: 28, 
                                   status: "unresolved"

      expect(response).to have_http_status(:created)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body["text"]).to eq "new tweet"
    end
  end
end
