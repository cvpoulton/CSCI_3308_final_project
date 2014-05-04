require 'spec_helper'

describe "Friend Requests" do
	

	before(:each) do
		User.create!(:username => 'Chris',:first_name => 'jamal',:last_name =>'jacques', :password => 'pass1', :password_confirmation=> 'pass1')
		User.create!(:username => 'JP', :password=> 'pass2', :first_name => 'J', :last_name => 'P', :password_confirmation=>'pass2')
		expect do
  			PendingFriendship.create(:user_id => 1, :from_user => 2)
		end.to change(PendingFriendship, :count).by(1)

	end

	describe "Received Friend Requests" do
		#it "should appear on Preferences Page" do
		#	user_login('Chris', 'pass1')
		#	visit preferences_path
			#shouldPendingFriendship.find(:first, :conditions=>{:user_id => 1, :other_user => 2})

		#end

		it "should appear on their Profile Page" do
			visit login_path
			fill_in "Username",     with: "Chris"
			fill_in "Password",     with: "pass1"
			click_button "Login"
			visit profile_path(:userProfile => 2)
			expect(page).to have_content('Received!')
		end

		it "should add friend when added" do
			visit login_path
			fill_in "Username",     with: "Chris"
			fill_in "Password",     with: "pass1"
			click_button "Login"
			visit preferences_path
			expect do
				click_link('Add')
			end.to change(Friendship, :count).by(2)
			expect(page).to have_content('J P')
			expect(page).to have_content('Defriend')

		end

		it "should disappear when denied" do
			visit login_path
			fill_in "Username",     with: "Chris"
			fill_in "Password",     with: "pass1"
			click_button "Login"
			visit preferences_path
			expect do
			click_link('Deny')
			end.to change(PendingFriendship, :count).by(-1)
			expect(page).to_not have_content('J P')		
		end
	end

	describe "Requested Friend Requests" do
		it "should appear on their Profile Page" do
			visit login_path
			fill_in "Username",     with: "JP"
			fill_in "Password",     with: "pass2"
			click_button "Login"
			visit profile_path(:userProfile => 1)
			expect(page).to have_content('Sent!')
		end
	end
end


describe "Friendships" do
	
	before(:each) do
		User.create!(:username => 'Chris',:first_name => 'jamal',:last_name =>'jacques', :password => 'pass1', :password_confirmation=> 'pass1')
		User.create!(:username => 'JP', :password=> 'pass2', :first_name => 'J', :last_name => 'P', :quotes => "Yo bro", :interests => "Software Engineering", :password_confirmation=>'pass2')
		Friendship.create!(:user_id => 1, :other_user => 2)
		Friendship.create!(:user_id => 2, :other_user => 1)
	end

	describe "defriending" do
		it "should disappear when defriended" do
			visit login_path
			fill_in "Username",     with: "Chris"
			fill_in "Password",     with: "pass1"
			click_button "Login"
			visit preferences_path
			click_link('Defriend')
			expect(page).to_not have_content('J P')
		end

		it "should allow refriending after defriending" do
			visit login_path
			fill_in "Username",     with: "Chris"
			fill_in "Password",     with: "pass1"
			click_button "Login"
			visit preferences_path
			expect do
				click_link('Defriend')
			end.to change(Friendship, :count).by(-2)
			visit profile_path(:userProfile => 2)
			expect(page).to have_content('J P') # Make sure we are on right page
			expect(page).to have_content('Send')
		end
	end

	describe "content when friends" do
		it "should appear in the friend list" do	
			visit login_path
			fill_in "Username",     with: "Chris"
			fill_in "Password",     with: "pass1"
			click_button "Login"
			visit preferences_path
			expect(page).to have_content('J P')
		end

		it "should allow us to see quotes and interests" do	
			visit login_path
			fill_in "Username",     with: "Chris"
			fill_in "Password",     with: "pass1"
			click_button "Login"
			visit profile_path(:userProfile => 2)
			expect(page).to have_content('J P')
			expect(page).to have_content('Yo bro')
			expect(page).to have_content('Software Engineering')
		end
	end
end
