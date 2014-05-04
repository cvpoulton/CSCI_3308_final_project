require 'spec_helper'

describe "Posting" do
	
	before(:each) do
		User.create!(:username => 'Chris', :password => 'pass1', :password_confirmation => 'pass1', :first_name => 'Chris', :last_name => 'Poulton', :walldate => Time.now)
		User.create!(:username => 'JP', :password=> 'pass2', :password_confirmation => 'pass2', :first_name => 'Jay', :last_name => 'Pii', :walldate => Time.now)
		Friendship.create(:user_id => 1, :other_user => 2)
		Friendship.create(:user_id => 2, :other_user => 1)
	end

	describe "Posting on walls" do
		it "should be possible on friends' walls" do
			user_login('Chris', 'pass1')
			visit profile_path(:userProfile => 2)
			fill_in('Message', :with=>'Hi Jaaayyy')
			click_button('Post to wall')
			assert Post.count == 1
		end

		it "should be possible on own wall" do
			user_login('Chris', 'pass1')
			visit profile_path(:userProfile => 1)
			fill_in('Message', :with=>'This is cool')
			click_button('Post status')
			assert Post.count == 1
		end

		it "should be possible from newsfeed" do
			user_login('Chris', 'pass1')
			visit newsfeed_path
			fill_in('Status', :with=>'Newsfeed status!!')
			click_button('Post status')
			assert Post.count == 1

		end
	end
end
