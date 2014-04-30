class AccountController < ApplicationController
  before_filter :redirect_if_not_logged_in, only: [:friends, :preferences, :update, :send_request, :add, :deny]

  def login
    if session.has_key?(:login_id) # If logged in already
      @current_user = User.find(session[:login_id]) # Set current user for header
    end
  end

  def login_check #Check if supplied data (from params) is actually a username/password combo
    @potential_users = User.find(:all, :conditions => {:username => params[:login][:username]})
    if @potential_users.length != 1 # No or more than one user found
      flash[:error] = "Username not found!"
      redirect_to login_path
    elsif @potential_users[0].password == params[:login][:password] # Only one user found and it was the right password
      session[:login_id] = @potential_users[0].id
      @current_user = @potential_users[0]
      redirect_to newsfeed_path
    else # Password was wrong
      flash[:error] = "Wrong password!"
      redirect_to login_path
    end
  end

  def logout
    session[:login_id] = nil
    redirect_to login_path
  end

  def new
    if session.has_key?(:login_id) # If logged in already
      @current_user = User.find(session[:login_id]) # Set current user for header
    end
  end

  def friends
    if params.has_key?(:search) # User is searching for last name
      @matched_users = User.find(:all, :conditions => {:last_name => params[:search][:lastName]}) # Pass view all users with given last name
    else
      @matched_users = [] # Don't display anything if nothing was searched
    end
  end

  def preferences
    @pending_friends = []
    @current_user.pending_friendships.each do |pending_friend|
      @pending_friends.append(User.find_by_id(pending_friend.from_user))
    end

    @friends = []
    @current_user.friendships.each do |friend|
      @friends.append(User.find_by_id(friend.other_user))
    end
  end

  def update
    @current_user.update_column(:interests, params[:current_user][:interests]) # update_column() doesn't do validation checks
    @current_user.update_column(:quotes, params[:current_user][:quotes])
    flash[:message] = "Updated profile!"
    redirect_to preferences_path
  end

  def create # No view associated with it
      @new_user = User.create(params[:user]) # Create new user
      if @new_user.valid?
        @current_user = @new_user
        session[:login_id] = @current_user.id
        @current_user.walldate = Time.now
        @current_user.save!
        redirect_to newsfeed_path # Redirect to Newsfeed
      else
        flash[:error] = @new_user.errors.full_messages()[0]
        redirect_to new_path # Redirect to make new account
      end
  end

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
    flash[:message] = "Friend request sent to #{User.find_by_id(params[:request_user]).first_name}!"
    PendingFriendship.create!(:user_id => params[:request_user], :from_user => session[:login_id])
    redirect_to profile_path(:userProfile => params[:request_user])
  end


  def deny
    pendingFriend = PendingFriendship.find(:all, :conditions => {:user_id => session[:login_id], :from_user => params[:deny_user]})
    flash[:message] = "Friend request from #{User.find_by_id(params[:deny_user]).first_name} denied!"
    PendingFriendship.destroy(pendingFriend[0].id)
    redirect_to preferences_path
  end

end
