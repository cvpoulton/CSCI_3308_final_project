class ViewingController < ApplicationController
  before_filter :redirect_if_not_logged_in
 
  def newsfeed
  end

  def profile
    @profile_user = User.find_by_id(params[:userProfile]) # The user of the profile we are trying to view
    if @profile_user == nil
      flash[:error] = "User not found!"
      redirect_to newsfeed_path
    else

      friends_bool = Friendship.find(:all, :conditions => {:user_id => @current_user.id, :other_user => @profile_user.id}).length == 1

      if friends_bool == true or @current_user.id == @profile_user.id 
	@type = 'friends'
      elsif PendingFriendship.find(:all, :conditions => {:user_id => @profile_user.id, :from_user => @current_user.id}).length == 1
        @type = 'requested'
      elsif PendingFriendship.find(:all, :conditions => {:user_id => @current_user.id, :from_user => @profile_user.id}).length == 1
	@type = 'received_request'
      else
        @type = 'not_friends'
      end

      render :template => "viewing/profile"
    end
  end


end
