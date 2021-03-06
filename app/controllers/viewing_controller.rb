class ViewingController < ApplicationController
  before_filter :redirect_if_not_logged_in

  def post # Post to someone's wall (could be your own!)
    if params[:post][:message] =~ /\S+/ # Make sure we don't get messages with just whitespace
      @new_post = Post.new
      @new_post.from_user = session[:login_id]
      @new_post.message = params[:post][:message]
      @new_post.user_id = params[:post_user]
      @new_post.save
    end
    if params[:from_newsfeed] == "true" # If we posted a status from the newsfeed page then redirect there
      redirect_to newsfeed_path
    else # We posted on a wall
      redirect_to profile_path(:userProfile=>params[:post_user])
    end
  end

  def newsfeed
    @posts = @current_user.posts # Get logged in user's posts
    @current_user.friendships.each do |friend|
      @posts = @posts + User.find_by_id(friend.other_user).posts # Add posts of friends
    end
    @posts.sort! { |x,y| if x.created_at > y.created_at then -1 else 1 end} # Sort posts by time created
    @posts = @posts[0..24] # Only show first 25 posts
  end

  def profile
    @profile_user = User.find_by_id(params[:userProfile]) # The user of the profile we are trying to view
    if @profile_user == nil
      flash[:error] = "User not found!"
      redirect_to newsfeed_path
    else

      friends_bool = Friendship.find(:all, :conditions => {:user_id => @current_user.id, :other_user => @profile_user.id}).length == 1 # Boolean if we are friends or not

      if friends_bool == true or @current_user.id == @profile_user.id # If friends or on own profile
	      @type = 'friends'
        @posts_raw = User.find_by_id(params[:userProfile]).posts.reverse
        @posts = []
        @posts_raw.each do |post|
          if User.find_by_id(session[:login_id]).walldate < post.created_at
             @posts.append(post) # Make list of displayed posts that were created after 'walldate'
          end
        end

      elsif PendingFriendship.find(:all, :conditions => {:user_id => @profile_user.id, :from_user => @current_user.id}).length == 1
        @type = 'requested' # If we have sent them a friend request

      elsif PendingFriendship.find(:all, :conditions => {:user_id => @current_user.id, :from_user => @profile_user.id}).length == 1
	      @type = 'received_request' # If we have receieved a friend request from them

      else
        @type = 'not_friends'
      end

      render :template => "viewing/profile"
    end
  end

end
