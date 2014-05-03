class FriendController < ApplicationController
  before_filter :redirect_if_not_logged_in

  def add
    pendingFriend = PendingFriendship.find(:all, :conditions => {:user_id => session[:login_id], :from_user => params[:add_user]})
    PendingFriendship.destroy(pendingFriend[0].id)
    Friendship.create!(:user_id => session[:login_id], :other_user => params[:add_user])
    Friendship.create!(:other_user => session[:login_id], :user_id => params[:add_user])
    flash[:message] = "#{User.find_by_id(params[:add_user]).first_name} added as friend!"
    redirect_to preferences_path
  end

  def defriend
    Friendship.destroy(Friendship.find(:first, :conditions => {:user_id => session[:login_id],     :other_user => params[:defriend_user]}).id)
    Friendship.destroy(Friendship.find(:first, :conditions => {:user_id => params[:defriend_user], :other_user => session[:login_id]}).id)
    flash[:message] = "Defriended #{User.find_by_id(params[:defriend_user]).first_name}!"
    redirect_to preferences_path
  end

  def send_request
    PendingFriendship.create!(:user_id => params[:request_user], :from_user => session[:login_id])
    flash[:message] = "Friend request sent to #{User.find_by_id(params[:request_user]).first_name}!"
    redirect_to profile_path(:userProfile => params[:request_user])
  end

  def deny
    pendingFriend = PendingFriendship.find(:all, :conditions => {:user_id => session[:login_id], :from_user => params[:deny_user]})
    PendingFriendship.destroy(pendingFriend[0].id)
    flash[:message] = "Friend request from #{User.find_by_id(params[:deny_user]).first_name} denied!"
    redirect_to preferences_path
  end
end
