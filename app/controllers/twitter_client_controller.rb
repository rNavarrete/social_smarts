class TwitterClientController < ApplicationController
  # respond_to :json, :html
  # before_filter :require_sigin!

  def index
    if current_user
      @tweets = current_user.fetch_tweets
      @mentions = current_user.fetch_mentions
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: [@tweets, @mentions] }
      end
    end
  end

  def create
    current_user.tweet(params[:tweet])
    redirect_to root_path
  end
end
