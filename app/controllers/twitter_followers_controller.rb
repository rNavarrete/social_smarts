class TwitterFollowersController < ApplicationController
  respond_to :json
  before_filter :require_signin!

  def index
    @followers = current_user.fetch_followers
  end
end
