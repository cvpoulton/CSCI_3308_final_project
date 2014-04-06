class ViewingController < ApplicationController
  def newsfeed
    if not session.has_key?(:login_id) # If not logged in then redirect to login page
      redirect_to '/account/login'
    else
      @current_user = User.find(session[:login_id]) # Set current user for header
    end
  end

  def profile
    if not session.has_key?(:login_id) # If not logged in then redirect to login page
      redirect_to '/account/login'
    else
      @current_user = User.find(session[:login_id]) # Set current user for header
    end
  end
end
