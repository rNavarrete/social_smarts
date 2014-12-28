class TwitterLocationController < ApplicationController
  respond_to :json
  before_filter :require_signin!

  def index
    @location = current_user.location
    respond_with @location
  end

end
