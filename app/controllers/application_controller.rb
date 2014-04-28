class ApplicationController < ActionController::Base
  protect_from_forgery

  def redirect_if_not_logged_in
    if not session.has_key?(:login_id) # If not logged in then redirect to login page
      redirect_to login_path
    else
      @current_user = User.find(session[:login_id]) # Set current user for header
    end
  end

end
