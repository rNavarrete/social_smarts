class TwitterMentionsController < ApplicationController
  respond_to :json
  before_filter :require_signin!

  def index
    @mentions = current_user.fetch_mentions
    respond_with @mentions
  end
end
