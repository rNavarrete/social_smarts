class TrackedTweetsController < ApplicationController
  respond_to :json
  before_filter :require_signin!

  def index
    respond_with current_user.tracked_tweets
  end

  def create
    tracked_tweet_params = {
      text: params[:text],
      screen_name: params[:screen_name],
      created_at: params[:created_at],
      klout_score: params[:klout_score],
      status: params[:status],
      image: params[:image]
    }

    tracked_tweet = current_user.tracked_tweets.new(tracked_tweet_params)
    tracked_tweet.save

    respond_with tracked_tweet
  end

  def update
    tracked_tweet = current_user.tracked_tweets.find(params[:id])
    tracked_tweet.status = params[:status]
    tracked_tweet.save
    respond_with tracked_tweet
  end

  def destroy
    respond_with current_user.tracked_tweets.destroy(params[:id])
  end
end
