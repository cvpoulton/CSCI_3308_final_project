class AccountController < ApplicationController
  before_filter :redirect_if_not_logged_in, only: [:friends, :preferences, :update, :clear_wall]

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
      @pending_friends.append(User.find_by_id(pending_friend.from_user)) # Make pending friend list for view
    end

    @friends = []
    @current_user.friendships.each do |friend|
      @friends.append(User.find_by_id(friend.other_user)) # Make friend list for view
    end
  end

  def update # Update profile
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
      else # An error was found
        flash[:error] = @new_user.errors.full_messages()[0] # Display error to user
        redirect_to new_path # Redirect to make new account
      end
  end

  def clear_wall
    @current_user.update_column(:walldate, Time.now) # We only display posts with create_time > walltime so this clears the wall
    flash[:message] = "Wall cleared!"
    redirect_to preferences_path
  end

end
