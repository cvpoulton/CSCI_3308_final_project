class ViewingController < ApplicationController
  before_filter :redirect_if_not_logged_in
 
  def post
      @new_post = Post.new
      @new_post.from_user=session[:login_id]
      @new_post.message=params[:post][:message]
      @new_post.user_id=params[:post_user]
      @new_post.time=Time.now
      @new_post.save
      redirect_to profile_path(:userProfile=>params[:post_user])
  end
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
        @posts_raw = User.find_by_id(params[:userProfile]).posts.reverse
        @posts = []
        @posts_raw.each do |post|
          if User.find_by_id(session[:login_id]).walldate < post.time
             @posts.append(post)
          end
        end
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
