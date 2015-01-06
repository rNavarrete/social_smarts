class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :null_session,
  if: Proc.new { |c| c.request.format =~ %r{application/json} }

  after_filter  :set_csrf_cookie_for_ng

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def require_signin!
    render status: 401,
          json: {
            success: false,
            info: "Unauthorized"
          } unless current_user
  end

  private

    def set_csrf_cookie_for_ng
      cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
    end
end
