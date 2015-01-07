RSpec.describe SessionsController, type: :controller do
  before do
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:twitter]
  end
    
  describe "POST create" do
    it "sets the user_id in the session" do
      post :create

      expect(session[:user_id]).to be
    end

    it "should redirect the user to the root" do
      post :create

      expect(response).to redirect_to root_path
    end
  end

  describe "DELETE destroy" do
    before do
      post :create
      expect(session[:user_id]).to be
    end

    it "should clear the session" do
      delete :destroy

      expect(session[:user_id]).to be_nil
    end

    it "should redirect to the root" do
      delete :destroy

      expect(response).to redirect_to root_path
    end
  end

end
