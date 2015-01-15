describe TrackedTweetsController do
  let(:user) { create(:user) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return user
    create(:tracked_tweet, user: user, id: 2)
    create(:tracked_tweet, user: user, id: 3)
  end

  describe "GET index" do
    it "responds with a json array of tracked tweets" do
      get :index, format: :json, status: "unresolved"

      expect(response.status).to eq 200
      expect(parsed_json_response_body[0]["text"]).to eq "tweeting"
    end
  end

  describe "POST create" do
    it "responds with a created tracked tweet in JSON" do
      post :create, format: :json, text: "new tweet", screen_name: "kavita", created_at: "today", klout_score: 28, status: "unresolved"

      expect(response).to have_http_status(:created)
      expect(parsed_json_response_body["text"]).to eq "new tweet"
    end
  end

  describe "PATCH update" do
    it "updates a tracked tweet and returns it in JSON" do
      patch :update, format: :json, id: 2, status: "resolved"

      expect(response).to have_http_status(:no_content)
      expect(TrackedTweet.find(2).status).to eq "resolved"
    end
  end

  describe "DELETE destroy" do
    it "deletes a tracked tweet" do
      delete :destroy, id: 2, format: :json

      expect(response).to have_http_status(:no_content)
      expect{ TrackedTweet.find(2) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
