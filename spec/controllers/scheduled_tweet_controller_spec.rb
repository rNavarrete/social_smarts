describe TwitterTimelineController, type: :controller do
  render_views

  let(:user) {create(:user)}

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return user
    allow_any_instance_of(Tweet).to receive(:user_klout_score).and_return 1
  end

  describe 'create' do
    it "posts a tweet" do
      VCR.use_cassette("create_scheduled_tweet") do
        expect(response.code).to eq '200'
      end
    end
  end

end
