class TwitterTimelineController < ApplicationController
  respond_to :json
  before_filter :require_signin!

  def index
    @tweets = current_user.fetch_tweets
    respond_with @tweets
  end

  def create
    current_user.tweet(params[:tweet])
    redirect_to root_path
  end
end
