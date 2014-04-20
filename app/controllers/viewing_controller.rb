class ViewingController < ApplicationController
  before_filter :redirect_if_not_logged_in
 
  def newsfeed
  end

  def profile
    @profile_user = User.find_by_id(params[:userProfile]) # The user of the profile we are trying to view
    if @profile_user == nil
      flash[:error] = "User not found!"
      redirect_to newsfeed_path
    elsif @current_user.friendships.include?(@profile_user) or @current_user.id == @profile_user.id 
      render :template => "viewing/profileFriend"
    else # Not friends
      render :template => "viewing/profileNonFriend"
    end

  end

end
