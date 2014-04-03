class ViewingController < ApplicationController
  def newsfeed
    if not session.has_key?(:login_id) # If not logged in then redirect to login page
      redirect_to '/account/login'
    end
  end

  def profile
    if not session.has_key?(:login_id) # If not logged in then redirect to login page
      redirect_to '/account/login'
    end
  end
end
