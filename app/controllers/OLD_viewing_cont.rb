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
# WE CAN REFACTOR ALL OF THIS, views and controllers!
      pending_friends_bool = false
      @profile_user.pending_friendships.each do |pending_friend|
        if pending_friend.from_user == @current_user.id
          pending_friends_bool = true
        end
      end

      received_request_bool = false
      @current_user.pending_friendships.each do |pending_friend|
        if pending_friend.from_user == @profile_user.id
          received_request_bool = true
        end
      end

      if friends_bool == true or @current_user.id == @profile_user.id 
        render :template => "viewing/profileFriend"
      elsif pending_friends_bool
        render :template => "viewing/profileNonFriendRequested"
      elsif received_request_bool
        render :template => "viewing/profileNonFriendReceived"
      else
        render :template => "viewing/profileNonFriend"
      end
    end
  end


end
