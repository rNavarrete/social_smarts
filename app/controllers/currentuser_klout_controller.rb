class CurrentuserKloutController < ApplicationController
  respond_to :json
  before_filter :require_signin!

  def index
    @klout_score = current_user.klout_score
  end

end
