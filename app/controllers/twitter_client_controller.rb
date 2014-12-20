class TwitterClientController < ApplicationController
  respond_to :json, :html
  # before_filter :require_sigin!

  def index
    if current_user
      @tweets = current_user.fetch_tweets
      @mentions = current_user.fetch_mentions
      respond_with [@tweets, @mentions]
    end
  end

  $ajax ->
    url: website.com/api/tweets

  website.com/api/tweets
  TweetsController#index
  website.com/api/mentions
  MentionsController#index
  rivers.com/api/mentions/35
  MentionsController#show

  website.com/api/users


  def create
    current_user.tweet(params[:tweet])
    redirect_to root_path
  end
end
