RSpec.describe TrackedTweetsController do
  let(:user) { create(:user) }

  before do
    request.session[:user_id] = user.id
    create(:tracked_tweet, user: user, id: 1)
    create(:tracked_tweet, user: user, id: 2)
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
    it "responds with a created tracked tweet in JSON" do
      post :create, format: :json, text: "new tweet", screen_name: "kavita", created_at: "today", klout_score: 28, status: "unresolved"

      expect(response).to have_http_status(:created)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body["text"]).to eq "new tweet"
    end
  end

  describe "PATCH update" do
    it "updates a tracked tweet and returns it in JSON" do
      patch :update, format: :json, id: 1, status: "resolved" 
      expect(response).to have_http_status(:no_content)
      expect(TrackedTweet.find(1).status).to eq "resolved"
    end
  end

  describe "DELETE destroy" do
    it "deletes a tracked tweet" do
      delete :destroy, id: 1, format: :json
      expect(response).to have_http_status(:no_content)
      expect{ TrackedTweet.find(1) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
