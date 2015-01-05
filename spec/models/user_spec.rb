RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it "has updateable auth attrs" do
    expect(user.provider).to eq "twitter"
    user.provider = "github"
    expect(user.provider).to eq "github"

    expect(user.uid).to eq "2935410678"
    user.uid = "1234"
    expect(user.uid).to eq "1234"

    expect(user.name).to eq "Social Smarts"
    user.name = "lukeaiken"
    expect(user.name).to eq "lukeaiken"

    expect(user.oauth_token).to eq "2935410678-GpBDrY8zuSDIXhX9TBOEZCFroNvmZzpgGELOecm"
    user.oauth_token = "new token"
    expect(user.oauth_token).to eq "new token"

    expect(user.oauth_secret).to eq "un2eJJAWAIJoHrzuHN9B3oJf9SidobAzFKL6KlSywmVvF"
    user.oauth_secret = "new secret"
    expect(user.oauth_secret).to eq "new secret"
  end
end
