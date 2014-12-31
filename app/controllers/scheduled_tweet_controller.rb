class ScheduledTweetController < ApplicationController
  respond_to :json
  before_filter :require_signin!

  def create
    @ScheduledTweet = ScheduledTweet.create(text: params[:tweet], user_id: current_user.id, time: params[:time], date: params[:date])
    respond_with( { status: 'ok' }.to_json, status: 201, location: root_path )
  end


end
