require 'spec_helper'

describe "Friend Requests" do
	
	before(:each) do
		User.create!(:username => 'Chris', :password => 'pass1')
		User.create!(:username => 'JP', :password=> 'pass2', :first_name => 'J', :last_name => 'P')
		PendingFriendship.create(:user_id => 1, :from_user => 2)

	end

	describe "Received Friend Requests" do
		it "should appear on Preferences Page" do
			user_login('Chris', 'pass1')
			visit preferences_path
			expect(page).to have_content('J P')
			expect(page).to have_content('Add')
			expect(page).to have_content('Deny')
		end

		it "should appear on their Profile Page" do
			user_login('Chris', 'pass1')
			visit profile_path(:userProfile => 2)
			expect(page).to have_content('Received!')
		end

		it "should add friend when added" do
			user_login('Chris', 'pass1')
			visit preferences_path
			click_link('Add')
			expect(page).to have_content('J P')
			expect(page).to have_content('Defriend')

		end

		it "should disappear when denied" do
			user_login('Chris', 'pass1')
			visit preferences_path
			click_link('Deny')
			expect(page).to_not have_content('J P')		
		end
	end

	describe "Requested Friend Requests" do
		it "should appear on their Profile Page" do
			user_login('JP', 'pass2')
			visit profile_path(:userProfile => 1)
			expect(page).to have_content('Sent!')
		end
	end
end


describe "Friendships" do
	
	before(:each) do
		User.create!(:username => 'Chris', :password => 'pass1')
		User.create!(:username => 'JP', :password=> 'pass2', :first_name => 'J', :last_name => 'P', :quotes => "Yo bro", :interests => "Software Engineering")
		Friendship.create!(:user_id => 1, :other_user => 2)
		Friendship.create!(:user_id => 2, :other_user => 1)
	end

	describe "defriending" do
		it "should disappear when defriended" do
			user_login('Chris', 'pass1')
			visit preferences_path
			click_link('Defriend')
			expect(page).to_not have_content('J P')
		end

		it "should allow refriending after defriending" do
			user_login('Chris', 'pass1')
			visit preferences_path
			click_link('Defriend')
			visit profile_path(:userProfile => 2)
			expect(page).to have_content('J P') # Make sure we are on right page
			expect(page).to have_content('Send')
		end
	end

	describe "content when friends" do
		it "should appear in the friend list" do	
			user_login('Chris', 'pass1')
			visit preferences_path
			expect(page).to have_content('J P')
		end

		it "should allow us to see quotes and interests" do	
			user_login('Chris', 'pass1')
			visit profile_path(:userProfile => 2)
			expect(page).to have_content('J P')
			expect(page).to have_content('Yo bro')
			expect(page).to have_content('Software Engineering')
		end
	end
end