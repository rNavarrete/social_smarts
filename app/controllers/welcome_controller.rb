class WelcomeController < ApplicationController
  before_filter :require_signin!, except: [:index]
  layout :choose_layout 

  def index
  end

  def choose_layout
    user_signed_in? ? "angular" : "application"
  end
end
