class TwitterUsermentionsController < ApplicationController
  respond_to :json
  before_filter :require_signin!

  def index
    @usermentions = current_user.fetch_mentions
    # respond_with @usermentions
  end
end
