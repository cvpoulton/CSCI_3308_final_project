class AccountController < ApplicationController
  def login
    if session.has_key?(:login_id) # If logged in already
      @current_user = User.find(session[:login_id]) # Set current user for header
    end
  end

  def login_check #Check if supplied data (from params) is actually a username/password combo
    @potential_users = User.find(:all, :conditions => {:username => params[:login][:username]})
    if @potential_users.length != 1 # No or more than one user found
      flash[:error] = "Username not found!"
      redirect_to '/account/login'
    elsif @potential_users[0].password == params[:login][:password] # Only one user found and it was the right password
      session[:login_id] = @potential_users[0].id
      @current_user = @potential_users[0]
      redirect_to '/viewing/newsfeed'
    else # Password was wrong
      flash[:error] = "Wrong password!"
      redirect_to '/account/login'
    end

  end

  def new
    if session.has_key?(:login_id) # If logged in already
      @current_user = User.find(session[:login_id]) # Set current user for header
    end
  end

  def friends
    if not session.has_key?(:login_id) # If not logged in then redirect to login page
      redirect_to '/account/login'
    else
      @current_user = User.find(session[:login_id]) # Set current user for header
    end
  end

  def preferences
    if not session.has_key?(:login_id) # If not logged in then redirect to login page
      redirect_to '/account/login'
    else
      @current_user = User.find(session[:login_id]) # Set current user for header
    end
  end

  def create # No view associated with it
    if User.find(:all, :conditions => {:username => params[:user][:username]}).length != 0 
      flash[:error] = "Username already taken!"
      redirect_to '/account/new' # If username already exisits don't let them make the account
    elsif params[:user][:username] == "" or params[:user][:first_name] == "" or params[:user][:last_name] == "" or params[:user][:password] == "" or params[:confirm][:passwordConfirm] == ""
      flash[:error] = "Must specify username, first and last name, and password along with confirmation!"
      redirect_to '/account/new'
    elsif params[:user][:password] != params[:confirm][:passwordConfirm]
      flash[:error] = "Password confirmation does not match password!"
      redirect_to '/account/new'
    else
      @current_user = User.create!(params[:user]) # Create new user
      session[:login_id] = @current_user.id
      @current_user.walldate = Time.now
      @current_user.save!
      redirect_to '/viewing/newsfeed' # Redirect to Newsfeed
    end
  end
end
