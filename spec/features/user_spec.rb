require 'rails_helper'

describe 'User' do
  context 'prior to logging in' do
    it 'has a login link' do
      WebMock.disable!
        visit root_path
        expect(page).to have_link('Login With Twitter', href: login_path)
  end

    xit "can successfully log in" do
      user = User.create({provider: "twitter", uid: "1", name: "Sara", oauth_token: "token", oauth_secret: "secret" })
      visit root_path
      log_in(user)
      save_and_open_page
      expect(page).to have_link('Logout')
    end
  end
end

def log_in(user)
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
    'provider' => 'twitter',
    'uid' => user.uid,
    'info' => { "name" => user.name, "image" => user.image },
    'credentials' => {"token" => user.oauth_token, "secret" => user.oauth_secret }
    })
    visit "/auth/twitter/callback"
end
