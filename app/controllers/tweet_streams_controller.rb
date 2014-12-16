class TweetStreamsController < ApplicationController
  def new
  end

  def create
    @tweets = twitter_client.fetch_tweets(params[:twitter_handle])
  end

  def twitter_client
    @twitter_client ||= TwitterClient.new
  end
end