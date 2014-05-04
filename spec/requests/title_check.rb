require 'spec_helper'


describe "Webpage" do
	
	before(:each) do
			User.create(:username => 'yo', :password => 'man', :password_confirmation => 'man', :first_name => 'Chris', :last_name => 'Poulton', :walldate => Time.now)
			user_login('yo', 'man')
	end

	describe "Newsfeed Title" do

		it "should have the title 'Newsfeed'" do
			visit newsfeed_path
			expect(page).to have_title('Newsfeed')
		end
	end

	describe "Login" do

		it "should have the title 'Login'" do
			visit login_path
			expect(page).to have_title('Login')
		end
	end

	describe "Preferences Title" do
		it "should have the title 'Profile Preferences'" do
			visit preferences_path
			expect(page).to have_title('Profile Preferences')
		end
	end

	describe "Search/Add Users Title" do
		it "should have the title 'Search/Add Users'" do
			visit friends_path
			expect(page).to have_title('Search/Add Users')
		end
	end

	describe "Profile Page" do

		it "should have the title 'Profile Page'" do
			visit profile_path(:userProfile => 1)
			expect(page).to have_title('Profile Page')
		end
	end

	describe "Create New Account" do

		it "should have the title 'Create New Account'" do
			visit new_path
			expect(page).to have_title('Create New Account')
		end
	end



end
