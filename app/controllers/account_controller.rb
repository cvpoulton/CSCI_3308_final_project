class AccountController < ApplicationController
  def login
    # May want to check here if we are already logged in! 
    # Just render view
  end

  def login_check #Check if supplied data (from params) is actually a user/password combo
    params[:login][:name] =~ /^(.+) (.+)$/
    @potential_users = User.find(:all, :conditions => {:first_name => $1, :last_name => $2})
    if @potential_users.length != 1 # No or more than one user found
      redirect_to '/account/login'
    elsif @potential_users[0].password == params[:login][:password] # Only one user found and it was the right password
      session[:login_id] = @potential_users[0].id
      redirect_to '/viewing/newsfeed'
    else # Password was wrong
      redirect_to '/account/login'
    end

  end

  def new
    # Just render view
  end

  def friends
    if not session.has_key?(:login_id) # If not logged in then redirect to login page
      redirect_to '/account/login'
    end
  end

  def preferences
    if not session.has_key?(:login_id) # If not logged in then redirect to login page
      redirect_to '/account/login'
    end
  end

  def create # No view associated with it
    if User.find(:all, :conditions => {:username => params[:user][:username]}).length != 0 
      redirect_to '/account/new' # If username alraedy exisits don't let them make the account
    else
      @current_user = User.create!(params[:user]) # Create new user
      session[:login_id] = @current_user.id
      @current_user.walldate = Time.now
      @current_user.save!
      redirect_to '/viewing/newsfeed' # Redirect to Newsfeed
    end
  end
end
