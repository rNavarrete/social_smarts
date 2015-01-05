class CurrentuserKloutController < ApplicationController
  respond_to :json
  before_filter :require_signin!

  def index
    # binding.pry
    cu_klout_score
    # current_user_klout_score
    # respond_with @usermentions
  end

  def cu_klout_score
    @klout ||=  begin
      # binding.pry
      Klout::TwUser.new(current_user.uid).score.score.to_i
    rescue StandardError => ex
      Rails.logger.error("oops klout blew up, here's the info: #{ex.message}")
      "Oops can't get klout for this user"
    end
  end
end
