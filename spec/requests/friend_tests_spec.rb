require 'spec_helper'

describe "Friend Requests" do
	

	before(:each) do
		@user = FactoryGirl.create(:user, username: 'Chris', password: 'pass1', password_confirmation: 'pass1', first_name: 'chuck')
		@user2 = FactoryGirl.create(:user, username:"JP", password: 'pass2', password_confirmation: 'pass2', first_name: 'larry')
		
		expect do
  			PendingFriendship.create(:user_id => 1, :from_user => 2)
		end.to change(PendingFriendship, :count).by(1)

	end

	describe "Received Friend Requests" do

		it "should appear on their Profile Page" do
			user_login(@user.username, @user.password)
			visit profile_path(:userProfile => 2)
			expect(page).to have_content('Received!')
		end

		it "should add friend when added" do
			user_login(@user.username, @user.password)
			visit preferences_path
			expect do
				click_link('Add')
			end.to change(Friendship, :count).by(2)
			expect(page).to have_content("#{@user2.first_name}")
			expect(page).to have_content('Defriend')

		end

		it "should disappear when denied" do
			user_login(@user.username, @user.password)
			visit preferences_path
			expect do
				click_link('Deny')
			end.to change(PendingFriendship, :count).by(-1)		
		end
	end

	describe "Requested Friend Requests" do
		it "should appear on their Profile Page" do
			user_login(@user2.username, @user2.password)
			visit profile_path(:userProfile => 1)
			expect(page).to have_content('Sent!')
		end
	end
end


describe "Friendships" do
	
	before(:each) do
		@user = FactoryGirl.create(:user, username: 'Chris', password: 'pass1', password_confirmation: 'pass1', first_name: "chuck")
		@user2 = FactoryGirl.create(:user, username:"JP", password: 'pass2', password_confirmation: 'pass2', first_name: "larry")
		Friendship.create!(:user_id => 1, :other_user => 2)
		Friendship.create!(:user_id => 2, :other_user => 1)
	end

	describe "defriending" do
		it "should disappear when defriended" do
			user_login(@user.username, @user.password)
			visit preferences_path
			expect do
				click_link('Defriend')
			end.to change(Friendship, :count).by(-2)
		end

		it "should allow refriending after defriending" do
			user_login(@user.username, @user.password)
			visit preferences_path
			expect do
				click_link('Defriend')
			end.to change(Friendship, :count).by(-2)
			visit profile_path(:userProfile => 2)
			expect(page).to have_content("#{@user2.first_name}") # Make sure we are on right page
			expect(page).to have_content('Send')
		end
	end

	describe "content when friends" do
		it "should appear in the friend list" do	
			user_login(@user.username, @user.password)
			visit preferences_path
			expect(page).to have_content("#{@user2.first_name}")
		end

		it "should allow us to see quotes and interests" do	
			user_login(@user.username, @user.password)
			visit profile_path(:userProfile => 2)
			expect(page).to have_content("#{@user2.first_name} #{@user2.last_name}")
			expect(page).to have_content("#{@user2.interests}")
			expect(page).to have_content("#{@user2.quotes}")
		end
	end
end
