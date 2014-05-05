require 'spec_helper'

describe "Posting" do
	
	before(:each) do
		@user = FactoryGirl.create(:user, username: 'Chris', password: 'pass1', password_confirmation: 'pass1', first_name: 'Chris', last_name: 'Poulton', walldate: Time.now)
		@user2 = FactoryGirl.create(:user, username: 'JP', password: 'pass2', password_confirmation: 'pass2', first_name: 'Jay', last_name: 'Pii', walldate: Time.now)
		Friendship.create(:user_id => 1, :other_user => 2)
		Friendship.create(:user_id => 2, :other_user => 1)
	end

	describe "Posting on walls" do
		it "should be possible on friends' walls" do
			user_login("#{@user.username}", "#{@user.password}")
			visit profile_path(:userProfile => 2)
			fill_in('Message', :with=>'Hi Jaaayyy')
			expect do
				click_button('Post to wall')
			end.to change(Post, :count).by(1)
			assert Post.count == 1
		end

		it "should be possible on own wall" do
			user_login("#{@user.username}", "#{@user.password}")
			visit profile_path(:userProfile => 1)
			fill_in('Message', :with=>'This is cool')
			expect do
				click_button('Post status')
			end.to change(Post, :count).by(1)
			assert Post.count == 1
		end

		it "should be possible from newsfeed" do
			user_login("#{@user.username}", "#{@user.password}")
			visit newsfeed_path
			fill_in("Status", :with=>"Newsfeed status!!")
			expect do
				click_button('Post status')
			end.to change(Post, :count).by(1)
			assert Post.count == 1

		end
	end
end
