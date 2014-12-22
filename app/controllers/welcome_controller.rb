class WelcomeController < ApplicationController
  before_filter :require_signin!, except: [:index]
  layout :choose_layout 

  def index
  end

  def choose_layout
    current_user ? "angular" : "application"
  end
end
