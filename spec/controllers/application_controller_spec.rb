require_relative './helpers'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe ApplicationController do
  controller do
    before_filter :require_signin!
    def index; end
  end

  describe "unauthorized request" do
    it "renders a status of 401" do
      get :index
      
      expect(response).to have_http_status(401)
      expect(parsed_json_response["success"]).to eq false
      expect(parsed_json_response["info"]).to eq "Unauthorized"
    end
  end
end
