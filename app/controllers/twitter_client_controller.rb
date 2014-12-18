class TwitterClientController < ApplicationController
  respond_to :json
  # before_filter :require_sigin!

  def index
    if current_user
      @tweets = current_user.fetch_tweets
      @mentions = current_user.fetch_mentions
      @location = current_user.location
      @mentions_data = @mentions.map do |tweet|
                                      if tweet.attrs[:place]
                                          [tweet.attrs[:place][:bounding_box][:coordinates].flatten[1], tweet.attrs[:place][:bounding_box][:coordinates].flatten[0]]
                                      end
                                    end.compact
    end
  end

  def create
    current_user.tweet(params[:tweet])
    redirect_to root_path
  end
end
