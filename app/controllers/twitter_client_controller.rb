class TwitterClientController < ApplicationController

  def index
    @tweets = twitter_client.fetch_tweets('j3')
    @mentions = twitter_client.fetch_mentions
  end

  def create
    current_user.tweet(params[:tweet])
    redirect_to root_path
  end

  def twitter_client
    @twitter_client ||= TwitterClient.new
  end
end
