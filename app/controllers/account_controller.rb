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
    @friends = @current_user.friendships

    @friends = []
    @current_user.friendships.each do |friend|
      @friends.append(User.find_by_id(friend.other_user))
    end
  end

  def update
    @current_user.interests = params[:current_user][:interests]
    @current_user.quotes = params[:current_user][:quotes]
    @current_user.save!
    flash[:message] = "Updated profile!"
    redirect_to preferences_path
  end

  def create # No view associated with it
    if User.find(:all, :conditions => {:username => params[:user][:username]}).length != 0 
      flash[:error] = "Username already taken!"
      redirect_to new_path # If username already exisits don't let them make the account
    elsif params[:user][:username] == "" or params[:user][:first_name] == "" or params[:user][:last_name] == "" or params[:user][:password] == "" or params[:confirm][:passwordConfirm] == ""
      flash[:error] = "Must specify username, first and last name, and password along with confirmation!"
      redirect_to new_path
    elsif params[:user][:password] != params[:confirm][:passwordConfirm]
      flash[:error] = "Password confirmation does not match password!"
      redirect_to new_path
    else
      @current_user = User.create!(params[:user]) # Create new user
      session[:login_id] = @current_user.id
      @current_user.walldate = Time.now
      @current_user.save!
      redirect_to newsfeed_path # Redirect to Newsfeed
    end
  end

  def add
    pendingFriend = PendingFriendship.find(:all, :conditions => {:user_id => session[:login_id], :from_user => params[:add_user]})

    if pendingFriend.length != 1
      flash[:message] = params[:add_user]
      flash[:error] = "Something very wrong! More than one or 0 pending friends found"
      redirect_to preferences_path
    else
      PendingFriendship.destroy(pendingFriend[0].id)
      Friendship.create!(:user_id => session[:login_id], :other_user => params[:add_user])
      Friendship.create!(:other_user => session[:login_id], :user_id => params[:add_user])
      flash[:message] = "Friend added!"
      redirect_to preferences_path
    end
  end

  def defriend
    Friendship.destroy(Friendship.find(:first, :conditions => {:user_id => session[:login_id],     :other_user => params[:defriend_user]}).id)
    Friendship.destroy(Friendship.find(:first, :conditions => {:user_id => params[:defriend_user], :other_user => session[:login_id]}).id)
    flash[:message] = "Defriended!"
    redirect_to preferences_path
  end

  def send_request
    flash[:message] = "Friend request sent!"
    PendingFriendship.create!(:user_id => params[:request_user], :from_user => session[:login_id])
    redirect_to profile_path(:userProfile => params[:request_user])
  end


  def deny
    pendingFriend = PendingFriendship.find(:all, :conditions => {:user_id => session[:login_id], :from_user => params[:deny_user]})
    if pendingFriend.length != 1
      flash[:error] = "Something very wrong! More than one or 0 pending friends found"
      flash[:message] = "#{session[:login_id]} #{params[:add_user]} #{pendingFriend.length}"
    else
      flash[:message] = "Friend request denied!"
      PendingFriendship.destroy(pendingFriend[0].id)
    end
    redirect_to preferences_path
  end

end
