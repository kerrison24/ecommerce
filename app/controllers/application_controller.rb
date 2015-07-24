class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authorize
  protect_from_forgery with: :exception

  protected
    def authorize
      unless User.find_by(id: session[:user_id])
        flash[:error] = "Please log in"
        redirect_to login_url
      end
    end
end
